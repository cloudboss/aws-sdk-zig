const AIWorkloadDataSource = @import("ai_workload_data_source.zig").AIWorkloadDataSource;

/// A channel of input data for an AI workload configuration. Each channel has a
/// name and a data source.
pub const AIWorkloadInputDataConfig = struct {
    /// The logical name for the data channel.
    channel_name: []const u8,

    /// The data source for this channel.
    data_source: AIWorkloadDataSource,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .data_source = "DataSource",
    };
};
