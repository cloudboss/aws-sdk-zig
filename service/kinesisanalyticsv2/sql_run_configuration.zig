const InputStartingPositionConfiguration = @import("input_starting_position_configuration.zig").InputStartingPositionConfiguration;

/// Describes the starting parameters for a SQL-based Kinesis Data Analytics
/// application.
pub const SqlRunConfiguration = struct {
    /// The input source ID. You can get this ID by calling the DescribeApplication
    /// operation.
    input_id: []const u8,

    /// The point at which you want the application to start processing records from
    /// the streaming
    /// source.
    input_starting_position_configuration: InputStartingPositionConfiguration,

    pub const json_field_names = .{
        .input_id = "InputId",
        .input_starting_position_configuration = "InputStartingPositionConfiguration",
    };
};
