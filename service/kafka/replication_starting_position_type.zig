/// The type of replication starting position.
pub const ReplicationStartingPositionType = enum {
    latest,
    earliest,

    pub const json_field_names = .{
        .latest = "LATEST",
        .earliest = "EARLIEST",
    };
};
