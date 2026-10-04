const SearchType = @import("search_type.zig").SearchType;
const SearchStatus = @import("search_status.zig").SearchStatus;

/// Optional filters for ListSearches. When multiple filters are set, a search
/// must match all of them.
pub const ListSearchesFilters = struct {
    /// Returns only searches whose `groupId` is one of the listed values.
    group_id_filter: ?[]const []const u8 = null,

    /// Returns only searches whose `searchType` is one of the listed values.
    search_type_filter: ?[]const SearchType = null,

    /// Returns only searches started at or after this time.
    started_after: ?i64 = null,

    /// Returns only searches started at or before this time.
    started_before: ?i64 = null,

    /// Returns only searches whose status is one of the listed values.
    status_filter: ?[]const SearchStatus = null,

    pub const json_field_names = .{
        .group_id_filter = "groupIdFilter",
        .search_type_filter = "searchTypeFilter",
        .started_after = "startedAfter",
        .started_before = "startedBefore",
        .status_filter = "statusFilter",
    };
};
