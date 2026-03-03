/// Contains all the information about a fraudster.
pub const Fraudster = struct {
    /// The timestamp of when Voice ID identified the fraudster.
    created_at: ?i64 = null,

    /// The identifier of the domain that contains the fraudster.
    domain_id: ?[]const u8 = null,

    /// The service-generated identifier for the fraudster.
    generated_fraudster_id: ?[]const u8 = null,

    /// The identifier of the watchlists the fraudster is a part of.
    watchlist_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_id = "DomainId",
        .generated_fraudster_id = "GeneratedFraudsterId",
        .watchlist_ids = "WatchlistIds",
    };
};
