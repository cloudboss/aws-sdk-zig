const OptInStatus = @import("opt_in_status.zig").OptInStatus;

/// Information about the integration of DevOps Guru with CloudWatch log groups
/// for log anomaly detection. You can use this to update the configuration.
pub const LogsAnomalyDetectionIntegrationConfig = struct {
    /// Specifies if DevOps Guru is configured to perform log anomaly detection on
    /// CloudWatch log groups.
    opt_in_status: ?OptInStatus = null,

    pub const json_field_names = .{
        .opt_in_status = "OptInStatus",
    };
};
