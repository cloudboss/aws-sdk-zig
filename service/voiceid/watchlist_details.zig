/// Details of the watchlists in a domain.
pub const WatchlistDetails = struct {
    /// The identifier of the default watchlist.
    default_watchlist_id: []const u8,

    pub const json_field_names = .{
        .default_watchlist_id = "DefaultWatchlistId",
    };
};
