/// The reference details for the data lineage node.
pub const LineageNodeReference = struct {
    /// The event timestamp of the data lineage node.
    event_timestamp: ?i64,

    /// The ID of the data lineage node.
    id: ?[]const u8,

    pub const json_field_names = .{
        .event_timestamp = "eventTimestamp",
        .id = "id",
    };
};
