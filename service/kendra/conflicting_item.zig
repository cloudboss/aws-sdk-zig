/// Information about a conflicting query used across different sets of
/// featured results. When you create a featured results set, you must check
/// that the queries are unique per featured results set for each index.
pub const ConflictingItem = struct {
    /// The text of the conflicting query.
    query_text: ?[]const u8 = null,

    /// The identifier of the set of featured results that the conflicting
    /// query belongs to.
    set_id: ?[]const u8 = null,

    /// The name for the set of featured results that the conflicting query
    /// belongs to.
    set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_text = "QueryText",
        .set_id = "SetId",
        .set_name = "SetName",
    };
};
