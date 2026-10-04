const aws = @import("aws");

/// A per-run configuration that overrides or merges with fields from
/// `DefaultRunSetting` for a specific run.
pub const InlineSetting = struct {
    /// Per-run engine-specific settings. Use this field to specify configuration
    /// options that are specific to the workflow engine (for example, Nextflow
    /// profiles). Overrides `defaultRunSetting.engineSettings` for this run.
    engine_settings: ?[]const u8 = null,

    /// An optional user-friendly name for this run.
    name: ?[]const u8 = null,

    /// The expected Amazon Web Services account ID of the owner of the output S3
    /// bucket for this run.
    output_bucket_owner_id: ?[]const u8 = null,

    /// Override the destination S3 URI for this run's outputs.
    output_uri: ?[]const u8 = null,

    /// Per-run workflow parameters. Merged with `defaultRunSetting.parameters`;
    /// values in this object take precedence when keys overlap.
    parameters: ?[]const u8 = null,

    /// Override the priority for this run.
    priority: ?i32 = null,

    /// A customer-provided unique identifier for this run configuration within the
    /// batch. After submission, use `ListRunsInBatch` to map each `runSettingId` to
    /// the HealthOmics-generated `runId`.
    run_setting_id: []const u8,

    /// Per-run Amazon Web Services tags. Merged with `defaultRunSetting.runTags`;
    /// values in this object take precedence when keys overlap.
    run_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .engine_settings = "engineSettings",
        .name = "name",
        .output_bucket_owner_id = "outputBucketOwnerId",
        .output_uri = "outputUri",
        .parameters = "parameters",
        .priority = "priority",
        .run_setting_id = "runSettingId",
        .run_tags = "runTags",
    };
};
