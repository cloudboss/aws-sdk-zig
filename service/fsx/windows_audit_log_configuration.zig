const WindowsAccessAuditLogLevel = @import("windows_access_audit_log_level.zig").WindowsAccessAuditLogLevel;

/// The configuration that Amazon FSx for Windows File Server uses to audit and
/// log
/// user accesses of files, folders, and file shares on the Amazon FSx for
/// Windows File Server
/// file system. For more information,
/// see [
/// File access
/// auditing](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/file-access-auditing.html).
pub const WindowsAuditLogConfiguration = struct {
    /// The Amazon Resource Name (ARN) for the destination of the audit logs.
    /// The destination can be any Amazon CloudWatch Logs log group ARN or
    /// Amazon Kinesis Data Firehose delivery stream ARN.
    ///
    /// The name of the Amazon CloudWatch Logs log group must begin with
    /// the `/aws/fsx` prefix. The name of the Amazon Kinesis Data
    /// Firehose delivery stream must begin with the `aws-fsx` prefix.
    ///
    /// The destination ARN (either CloudWatch Logs log group or Kinesis
    /// Data Firehose delivery stream) must be in the same Amazon Web Services
    /// partition,
    /// Amazon Web Services Region, and Amazon Web Services account as your Amazon
    /// FSx file system.
    audit_log_destination: ?[]const u8,

    /// Sets which attempt type is logged by Amazon FSx for file and folder
    /// accesses.
    ///
    /// * `SUCCESS_ONLY` - only successful attempts to access files
    /// or folders are logged.
    ///
    /// * `FAILURE_ONLY` - only failed attempts to access files
    /// or folders are logged.
    ///
    /// * `SUCCESS_AND_FAILURE` - both successful attempts and
    /// failed attempts to access files or folders are logged.
    ///
    /// * `DISABLED` - access auditing of files and folders is turned off.
    file_access_audit_log_level: WindowsAccessAuditLogLevel,

    /// Sets which attempt type is logged by Amazon FSx for file share accesses.
    ///
    /// * `SUCCESS_ONLY` - only successful attempts to access file
    /// shares are logged.
    ///
    /// * `FAILURE_ONLY` - only failed attempts to access file
    /// shares are logged.
    ///
    /// * `SUCCESS_AND_FAILURE` - both successful attempts and
    /// failed attempts to access file shares are logged.
    ///
    /// * `DISABLED` - access auditing of file shares is turned off.
    file_share_access_audit_log_level: WindowsAccessAuditLogLevel,

    pub const json_field_names = .{
        .audit_log_destination = "AuditLogDestination",
        .file_access_audit_log_level = "FileAccessAuditLogLevel",
        .file_share_access_audit_log_level = "FileShareAccessAuditLogLevel",
    };
};
