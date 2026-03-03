/// Provides summary information about a configured model algorithm.
pub const ConfiguredModelAlgorithmSummary = struct {
    /// The Amazon Resource Name (ARN) of the configured model algorithm.
    configured_model_algorithm_arn: []const u8,

    /// The time at which the configured model algorithm was created.
    create_time: i64,

    /// The description of the configured model algorithm.
    description: ?[]const u8 = null,

    /// The name of the configured model algorithm.
    name: []const u8,

    /// The most recent time at which the configured model algorithm was updated.
    update_time: i64,

    pub const json_field_names = .{
        .configured_model_algorithm_arn = "configuredModelAlgorithmArn",
        .create_time = "createTime",
        .description = "description",
        .name = "name",
        .update_time = "updateTime",
    };
};
