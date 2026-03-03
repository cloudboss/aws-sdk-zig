const FraudDetectionAction = @import("fraud_detection_action.zig").FraudDetectionAction;

/// The fraud detection configuration to be used during the batch speaker
/// enrollment job.
pub const EnrollmentJobFraudDetectionConfig = struct {
    /// The action to take when the given speaker is flagged by the fraud detection
    /// system.
    /// The default value is `FAIL`, which fails the speaker enrollment. Changing
    /// this value to `IGNORE` results in the speaker being enrolled even if they
    /// are
    /// flagged by the fraud detection system.
    fraud_detection_action: ?FraudDetectionAction = null,

    /// Threshold value for determining whether the speaker is a high risk to be
    /// fraudulent.
    /// If the detected risk score calculated by Voice ID is greater than or equal
    /// to the
    /// threshold, the speaker is considered a fraudster.
    risk_threshold: ?i32 = null,

    /// The identifier of watchlists against which fraud detection is performed.
    watchlist_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .fraud_detection_action = "FraudDetectionAction",
        .risk_threshold = "RiskThreshold",
        .watchlist_ids = "WatchlistIds",
    };
};
