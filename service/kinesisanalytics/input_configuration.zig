const InputStartingPositionConfiguration = @import("input_starting_position_configuration.zig").InputStartingPositionConfiguration;

/// When you start your application,
/// you provide this configuration, which identifies the input source and the
/// point
/// in the input source at which you want the application to start processing
/// records.
pub const InputConfiguration = struct {
    /// Input source ID. You can get this ID by calling
    /// the
    /// [DescribeApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_DescribeApplication.html) operation.
    id: []const u8,

    /// Point at which you want the application to start processing
    /// records from the streaming source.
    input_starting_position_configuration: InputStartingPositionConfiguration,

    pub const json_field_names = .{
        .id = "Id",
        .input_starting_position_configuration = "InputStartingPositionConfiguration",
    };
};
