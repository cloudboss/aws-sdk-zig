pub const BuildPhaseType = enum {
    submitted,
    queued,
    provisioning,
    download_source,
    install,
    pre_build,
    build,
    post_build,
    upload_artifacts,
    finalizing,
    completed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .queued = "QUEUED",
        .provisioning = "PROVISIONING",
        .download_source = "DOWNLOAD_SOURCE",
        .install = "INSTALL",
        .pre_build = "PRE_BUILD",
        .build = "BUILD",
        .post_build = "POST_BUILD",
        .upload_artifacts = "UPLOAD_ARTIFACTS",
        .finalizing = "FINALIZING",
        .completed = "COMPLETED",
    };
};
