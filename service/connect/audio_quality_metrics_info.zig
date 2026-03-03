/// Contains information for score and potential quality issues for Audio
pub const AudioQualityMetricsInfo = struct {
    /// List of potential issues causing degradation of quality on a media
    /// connection. If the service did not detect any
    /// potential quality issues the list is empty.
    ///
    /// Valid values: `HighPacketLoss` | `HighRoundTripTime` |
    /// `HighJitterBuffer`
    potential_quality_issues: ?[]const []const u8 = null,

    /// Number measuring the estimated quality of the media connection.
    quality_score: f32 = 0,

    pub const json_field_names = .{
        .potential_quality_issues = "PotentialQualityIssues",
        .quality_score = "QualityScore",
    };
};
