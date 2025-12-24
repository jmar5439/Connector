/*
 *  Copyright (c) 2020, 2021 Microsoft Corporation
 *
 *  This program and the accompanying materials are made available under the
 *  terms of the Apache License, Version 2.0 which is available at
 *  https://www.apache.org/licenses/LICENSE-2.0
 *
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Contributors:
 *       Microsoft Corporation - initial API and implementation
 *       Fraunhofer Institute for Software and Systems Engineering - added dependencies
 *
 */

plugins {
    `java-library`
    id("application")
    alias(libs.plugins.shadow)
    alias(libs.plugins.edc.build)
}

dependencies {

    implementation(libs.edc.runtime.core)
    implementation(libs.edc.connector.core)
    implementation(libs.edc.control.api.configuration)
    implementation(libs.edc.control.plane.api.client)
    implementation(libs.edc.control.plane.api)
    implementation(libs.edc.control.plane.core)
    implementation(libs.edc.token.core)
    implementation(libs.edc.dsp)
    implementation(libs.edc.http)
    implementation(libs.edc.configuration.filesystem)
    implementation(libs.edc.iam.mock)
    implementation(libs.edc.management.api)
    
    // SQL persistence for control plane
     // Use the BOM (Bill of Materials) that includes all SQL dependencies
    implementation(platform(project(":dist:bom:controlplane-feature-sql-bom")))
    // PostgreSQL driver (or use H2 for testing)
    runtimeOnly(libs.postgres)
    // OR for H2 (in-memory testing):
    // runtimeOnly("com.h2database:h2:2.2.224")
    //implementation(project(":dist:bom:dataplane-feature-sql-bom"))
}

application {
    mainClass.set("org.eclipse.edc.boot.system.runtime.BaseRuntime")
}

tasks.withType<com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar> {
    mergeServiceFiles()
    archiveFileName.set("basic-04-my-new-connector.jar")
}
// Fix task dependency issues
tasks {
    distZip {
        dependsOn(shadowJar)
    }
    distTar {
        dependsOn(shadowJar)
    }
    startScripts {
        dependsOn(shadowJar)
    }
}