const ConfiguredAudienceModelOutputConfig = @import("configured_audience_model_output_config.zig").ConfiguredAudienceModelOutputConfig;
const ConfiguredAudienceModelStatus = @import("configured_audience_model_status.zig").ConfiguredAudienceModelStatus;

/// Information about the configured audience model.
pub const ConfiguredAudienceModelSummary = struct {
    /// The Amazon Resource Name (ARN) of the audience model that was used to create
    /// the configured audience model.
    audience_model_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the configured audience model that you are
    /// interested in.
    configured_audience_model_arn: []const u8,

    /// The time at which the configured audience model was created.
    create_time: i64,

    /// The description of the configured audience model.
    description: ?[]const u8,

    /// The name of the configured audience model.
    name: []const u8,

    /// The output configuration of the configured audience model.
    output_config: ConfiguredAudienceModelOutputConfig,

    /// The status of the configured audience model.
    status: ConfiguredAudienceModelStatus,

    /// The most recent time at which the configured audience model was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_model_arn = "audienceModelArn",
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .name = "name",
        .output_config = "outputConfig",
        .status = "status",
        .update_time = "updateTime",
    };
};
