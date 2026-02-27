const TimestreamConfiguration = @import("timestream_configuration.zig").TimestreamConfiguration;

/// Configuration used for writing the output of a query.
pub const TargetConfiguration = struct {
    /// Configuration needed to write data into the Timestream database and table.
    timestream_configuration: TimestreamConfiguration,

    pub const json_field_names = .{
        .timestream_configuration = "TimestreamConfiguration",
    };
};
