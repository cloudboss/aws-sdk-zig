const SearchType = @import("search_type.zig").SearchType;
const SearchStatus = @import("search_status.zig").SearchStatus;

/// A summary of a single search as returned by ListSearches.
pub const SearchSummary = struct {
    /// The group identifier associated with the search, if one was supplied on the
    /// request.
    group_id: ?[]const u8 = null,

    /// The natural-language query that was submitted for the search.
    query_statement: []const u8,

    /// The unique identifier of the search.
    search_id: []const u8,

    /// The search strategy used for the search.
    search_type: SearchType,

    /// The time at which the search was started.
    started_at: ?i64 = null,

    /// The current status of the search.
    status: SearchStatus,

    /// A human-readable explanation of the current status. Populated when the
    /// search has `FAILED`.
    status_reason: ?[]const u8 = null,

    /// The name of the workspace the search runs against.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .query_statement = "queryStatement",
        .search_id = "searchId",
        .search_type = "searchType",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .workspace_name = "workspaceName",
    };
};
