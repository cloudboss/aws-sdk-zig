const aws = @import("aws");

const PropertygraphData = @import("propertygraph_data.zig").PropertygraphData;

/// Structure of a property graph record.
pub const PropertygraphRecord = struct {
    /// The time at which the commit for the transaction was requested, in
    /// milliseconds from the Unix epoch.
    commit_timestamp_in_millis: i64,

    /// The serialized Gremlin or openCypher change record.
    data: PropertygraphData,

    /// The sequence identifier of the stream change record.
    event_id: []const aws.map.StringMapEntry,

    /// Only present if this operation is the last one in its transaction. If
    /// present, it is set to true. It is useful for ensuring that an entire
    /// transaction is consumed.
    is_last_op: ?bool,

    /// The operation that created the change.
    op: []const u8,

    pub const json_field_names = .{
        .commit_timestamp_in_millis = "commitTimestampInMillis",
        .data = "data",
        .event_id = "eventId",
        .is_last_op = "isLastOp",
        .op = "op",
    };
};
