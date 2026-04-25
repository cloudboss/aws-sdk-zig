/// Summary information about an AI workload configuration.
pub const AIWorkloadConfigSummary = struct {
    /// The Amazon Resource Name (ARN) of the AI workload configuration.
    ai_workload_config_arn: []const u8,

    /// The name of the AI workload configuration.
    ai_workload_config_name: []const u8,

    /// A timestamp that indicates when the configuration was created.
    creation_time: i64,

    pub const json_field_names = .{
        .ai_workload_config_arn = "AIWorkloadConfigArn",
        .ai_workload_config_name = "AIWorkloadConfigName",
        .creation_time = "CreationTime",
    };
};
