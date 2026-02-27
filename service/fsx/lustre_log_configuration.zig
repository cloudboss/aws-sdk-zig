const LustreAccessAuditLogLevel = @import("lustre_access_audit_log_level.zig").LustreAccessAuditLogLevel;

/// The configuration for Lustre logging used to write the enabled
/// logging events for your Amazon FSx for Lustre file system or
/// Amazon File Cache resource to Amazon CloudWatch Logs.
pub const LustreLogConfiguration = struct {
    /// The Amazon Resource Name (ARN) that specifies the destination of the logs.
    /// The destination can be any Amazon CloudWatch Logs log group ARN. The
    /// destination
    /// ARN must be in the same Amazon Web Services partition, Amazon Web Services
    /// Region,
    /// and Amazon Web Services account as your Amazon FSx file system.
    destination: ?[]const u8,

    /// The data repository events that are logged by Amazon FSx.
    ///
    /// * `WARN_ONLY` - only warning events are logged.
    ///
    /// * `ERROR_ONLY` - only error events are logged.
    ///
    /// * `WARN_ERROR` - both warning events and error events
    /// are logged.
    ///
    /// * `DISABLED` - logging of data repository events
    /// is turned off.
    ///
    /// Note that Amazon File Cache uses a default setting of `WARN_ERROR`,
    /// which can't be changed.
    level: LustreAccessAuditLogLevel,

    pub const json_field_names = .{
        .destination = "Destination",
        .level = "Level",
    };
};
