/// Contains a summary of information about a fraudster.
pub const FraudsterSummary = struct {
    /// The timestamp of when the fraudster summary was created.
    created_at: ?i64,

    /// The identifier of the domain that contains the fraudster summary.
    domain_id: ?[]const u8,

    /// The service-generated identifier for the fraudster.
    generated_fraudster_id: ?[]const u8,

    /// The identifier of the watchlists the fraudster is a part of.
    watchlist_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_id = "DomainId",
        .generated_fraudster_id = "GeneratedFraudsterId",
        .watchlist_ids = "WatchlistIds",
    };
};
