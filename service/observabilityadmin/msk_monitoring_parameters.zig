const MskEnhancedMonitoringLevel = @import("msk_enhanced_monitoring_level.zig").MskEnhancedMonitoringLevel;

/// Configuration parameters for Amazon MSK cluster monitoring, including
/// enhanced monitoring level settings.
pub const MskMonitoringParameters = struct {
    /// The level of enhanced monitoring for the MSK cluster.
    enhanced_monitoring: ?MskEnhancedMonitoringLevel = null,

    pub const json_field_names = .{
        .enhanced_monitoring = "EnhancedMonitoring",
    };
};
