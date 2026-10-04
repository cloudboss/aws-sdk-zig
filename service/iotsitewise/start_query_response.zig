const QueryStatus = @import("query_status.zig").QueryStatus;

/// Contains the response for the StartQuery operation.
pub const StartQueryResponse = struct {
    /// The unique identifier for the query execution.
    query_id: []const u8,

    /// The initial query status. The value is always SUBMITTED upon creation.
    status: QueryStatus,

    pub const json_field_names = .{
        .query_id = "queryId",
        .status = "status",
    };
};
