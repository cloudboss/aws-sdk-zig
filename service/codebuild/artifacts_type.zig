pub const ArtifactsType = enum {
    codepipeline,
    s3,
    no_artifacts,

    pub const json_field_names = .{
        .codepipeline = "CODEPIPELINE",
        .s3 = "S3",
        .no_artifacts = "NO_ARTIFACTS",
    };
};
