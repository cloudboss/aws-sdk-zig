const Hit = @import("hit.zig").Hit;

/// The collection of documents that match the search request.
pub const Hits = struct {
    /// A cursor that can be used to retrieve the next set of matching documents
    /// when you want to page through a large result set.
    cursor: ?[]const u8 = null,

    /// The total number of documents that match the search request.
    found: i64 = 0,

    /// A document that matches the search request.
    hit: ?[]const Hit = null,

    /// The index of the first matching document.
    start: i64 = 0,

    pub const json_field_names = .{
        .cursor = "cursor",
        .found = "found",
        .hit = "hit",
        .start = "start",
    };
};
