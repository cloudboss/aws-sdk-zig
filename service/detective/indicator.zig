const IndicatorDetail = @import("indicator_detail.zig").IndicatorDetail;
const IndicatorType = @import("indicator_type.zig").IndicatorType;

/// Detective investigations triages indicators of compromises such as a finding
/// and surfaces only the most critical and suspicious issues, so you can focus
/// on high-level
/// investigations. An `Indicator` lets you determine if an Amazon Web Services
/// resource is involved in unusual activity that could indicate malicious
/// behavior and its
/// impact.
pub const Indicator = struct {
    /// Details about the indicators of compromise that are used to determine if a
    /// resource is involved in a security incident. An indicator of compromise
    /// (IOC) is an artifact observed in or on a network, system, or environment
    /// that can (with a high level of confidence) identify malicious activity or a
    /// security incident.
    indicator_detail: ?IndicatorDetail,

    /// The type of indicator.
    indicator_type: ?IndicatorType,

    pub const json_field_names = .{
        .indicator_detail = "IndicatorDetail",
        .indicator_type = "IndicatorType",
    };
};
