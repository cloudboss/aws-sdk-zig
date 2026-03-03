const AvailMatchingCriteria = @import("avail_matching_criteria.zig").AvailMatchingCriteria;

/// The settings that determine how and when MediaTailor places prefetched ads
/// into upcoming ad breaks for recurring prefetch scedules.
pub const RecurringConsumption = struct {
    /// The configuration for the dynamic variables that determine which ad breaks
    /// that MediaTailor inserts prefetched ads in.
    avail_matching_criteria: ?[]const AvailMatchingCriteria = null,

    /// The number of seconds that an ad is available for insertion after it was
    /// prefetched.
    retrieved_ad_expiration_seconds: ?i32 = null,

    pub const json_field_names = .{
        .avail_matching_criteria = "AvailMatchingCriteria",
        .retrieved_ad_expiration_seconds = "RetrievedAdExpirationSeconds",
    };
};
