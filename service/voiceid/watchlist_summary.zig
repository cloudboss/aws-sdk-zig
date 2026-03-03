/// Contains a summary of information about a watchlist.
pub const WatchlistSummary = struct {
    /// The timestamp of when the watchlist was created.
    created_at: ?i64 = null,

    /// Whether the specified watchlist is the default watchlist of a domain.
    default_watchlist: bool = false,

    /// The description of the watchlist.
    description: ?[]const u8 = null,

    /// The identifier of the domain that contains the watchlist.
    domain_id: ?[]const u8 = null,

    /// The name for the watchlist.
    name: ?[]const u8 = null,

    /// The timestamp of when the watchlist was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the watchlist.
    watchlist_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .default_watchlist = "DefaultWatchlist",
        .description = "Description",
        .domain_id = "DomainId",
        .name = "Name",
        .updated_at = "UpdatedAt",
        .watchlist_id = "WatchlistId",
    };
};
