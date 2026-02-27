const TimestreamDestination = @import("timestream_destination.zig").TimestreamDestination;

/// Destination details to write data for a target data source. Current
/// supported data
/// source is Timestream.
pub const TargetDestination = struct {
    /// Query result destination details for Timestream data source.
    timestream_destination: ?TimestreamDestination,

    pub const json_field_names = .{
        .timestream_destination = "TimestreamDestination",
    };
};
