const DuplicateRegistrationAction = @import("duplicate_registration_action.zig").DuplicateRegistrationAction;

/// The registration configuration to be used during the batch fraudster
/// registration job.
pub const RegistrationConfig = struct {
    /// The action to take when a fraudster is identified as a duplicate. The
    /// default action
    /// is `SKIP`, which skips registering the duplicate fraudster. Setting the
    /// value
    /// to `REGISTER_AS_NEW` always registers a new fraudster into the specified
    /// domain.
    duplicate_registration_action: ?DuplicateRegistrationAction = null,

    /// The minimum similarity score between the new and old fraudsters in order to
    /// consider
    /// the new fraudster a duplicate.
    fraudster_similarity_threshold: ?i32 = null,

    /// The identifiers of watchlists that a fraudster is registered to. If a
    /// watchlist isn't provided, the fraudsters are registered to the default
    /// watchlist.
    watchlist_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .duplicate_registration_action = "DuplicateRegistrationAction",
        .fraudster_similarity_threshold = "FraudsterSimilarityThreshold",
        .watchlist_ids = "WatchlistIds",
    };
};
