const SearchStatus = @import("search_status.zig").SearchStatus;

/// Summary details of an archive search job.
pub const SearchSummary = struct {
    /// The unique identifier of the search job.
    search_id: ?[]const u8 = null,

    /// The current status of the search job.
    status: ?SearchStatus = null,

    pub const json_field_names = .{
        .search_id = "SearchId",
        .status = "Status",
    };
};
