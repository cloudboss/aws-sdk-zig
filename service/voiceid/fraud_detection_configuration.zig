/// The configuration used for performing fraud detection over a speaker during
/// a
/// session.
pub const FraudDetectionConfiguration = struct {
    /// Threshold value for determining whether the speaker is a fraudster. If the
    /// detected
    /// risk score calculated by Voice ID is higher than the threshold, the speaker
    /// is
    /// considered a fraudster.
    risk_threshold: ?i32,

    /// The identifier of the watchlist against which fraud detection is performed.
    watchlist_id: ?[]const u8,

    pub const json_field_names = .{
        .risk_threshold = "RiskThreshold",
        .watchlist_id = "WatchlistId",
    };
};
