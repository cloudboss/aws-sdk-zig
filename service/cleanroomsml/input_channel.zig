const InputChannelDataSource = @import("input_channel_data_source.zig").InputChannelDataSource;

/// Provides information about the data source that is used to create an ML
/// input channel.
pub const InputChannel = struct {
    /// The data source that is used to create the ML input channel.
    data_source: InputChannelDataSource,

    /// The Amazon Resource Name (ARN) of the role used to run the query specified
    /// in the `dataSource` field of the input channel.
    ///
    /// Passing a role across AWS accounts is not allowed. If you pass a role that
    /// isn't in your account, you get an `AccessDeniedException` error.
    role_arn: []const u8,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .role_arn = "roleArn",
    };
};
