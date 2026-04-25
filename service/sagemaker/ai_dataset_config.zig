const AIWorkloadInputDataConfig = @import("ai_workload_input_data_config.zig").AIWorkloadInputDataConfig;

/// The dataset configuration for an AI workload. This is a union type — specify
/// one of the members.
pub const AIDatasetConfig = union(enum) {
    /// An array of input data channel configurations for the workload.
    input_data_config: ?[]const AIWorkloadInputDataConfig,

    pub const json_field_names = .{
        .input_data_config = "InputDataConfig",
    };
};
