const LustreAccessAuditLogLevel = @import("lustre_access_audit_log_level.zig").LustreAccessAuditLogLevel;

/// The Lustre logging configuration used when creating or updating an
/// Amazon FSx for Lustre file system. An Amazon File Cache is created
/// with Lustre logging enabled by default, with a setting of
/// `WARN_ERROR` for the logging events. which can't be changed.
///
/// Lustre logging writes the enabled logging events for your file system
/// or cache to Amazon CloudWatch Logs.
pub const LustreLogCreateConfiguration = struct {
    /// The Amazon Resource Name (ARN) that specifies the destination of the logs.
    ///
    /// The destination can be any Amazon CloudWatch Logs log group ARN, with the
    /// following
    /// requirements:
    ///
    /// * The destination ARN that you provide must be in the same Amazon Web
    ///   Services partition,
    /// Amazon Web Services Region, and Amazon Web Services account as your Amazon
    /// FSx file system.
    ///
    /// * The name of the Amazon CloudWatch Logs log group must begin with
    /// the `/aws/fsx` prefix.
    ///
    /// * If you do not provide a destination, Amazon FSx will create and use a
    /// log stream in the CloudWatch Logs `/aws/fsx/lustre` log group
    /// (for Amazon FSx for Lustre) or `/aws/fsx/filecache`
    /// (for Amazon File Cache).
    ///
    /// * If `Destination` is provided and the resource does not
    /// exist, the request will fail with a `BadRequest` error.
    ///
    /// * If `Level` is set to `DISABLED`, you cannot specify
    /// a destination in `Destination`.
    destination: ?[]const u8,

    /// Sets which data repository events are logged by Amazon FSx.
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
    level: LustreAccessAuditLogLevel,

    pub const json_field_names = .{
        .destination = "Destination",
        .level = "Level",
    };
};
