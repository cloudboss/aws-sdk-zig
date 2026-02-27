/// The configuration for pre-roll ad insertion.
pub const LivePreRollConfiguration = struct {
    /// The URL for the ad decision server (ADS) for pre-roll ads. This includes the
    /// specification of static parameters and placeholders for dynamic parameters.
    /// AWS Elemental MediaTailor substitutes player-specific and session-specific
    /// parameters as needed when calling the ADS. Alternately, for testing, you can
    /// provide a static VAST URL. The maximum length is 25,000 characters.
    ad_decision_server_url: ?[]const u8,

    /// The maximum allowed duration for the pre-roll ad avail. AWS Elemental
    /// MediaTailor won't play pre-roll ads to exceed this duration, regardless of
    /// the total duration of ads that the ADS returns.
    max_duration_seconds: ?i32,

    pub const json_field_names = .{
        .ad_decision_server_url = "AdDecisionServerUrl",
        .max_duration_seconds = "MaxDurationSeconds",
    };
};
