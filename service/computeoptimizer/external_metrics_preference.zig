const ExternalMetricsSource = @import("external_metrics_source.zig").ExternalMetricsSource;

/// Describes the external metrics preferences for EC2 rightsizing
/// recommendations.
pub const ExternalMetricsPreference = struct {
    /// Contains the source options for external metrics preferences.
    source: ?ExternalMetricsSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
