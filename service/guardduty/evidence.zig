const ThreatIntelligenceDetail = @import("threat_intelligence_detail.zig").ThreatIntelligenceDetail;

/// Contains information about the reason that the finding was generated.
pub const Evidence = struct {
    /// A list of threat intelligence details related to the evidence.
    threat_intelligence_details: ?[]const ThreatIntelligenceDetail,

    pub const json_field_names = .{
        .threat_intelligence_details = "ThreatIntelligenceDetails",
    };
};
