/// The File Server Resource Manager (FSRM) configuration that Amazon FSx for
/// Windows File Server uses for the file system. When FSRM is enabled, you can
/// manage and monitor storage quotas, file screening, storage reports, and file
/// classification.
pub const WindowsFsrmConfiguration = struct {
    /// The Amazon Resource Name (ARN) for the destination of the FSRM event logs.
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
    event_log_destination: ?[]const u8 = null,

    /// Specifies whether FSRM is enabled or disabled on the file system. When
    /// `TRUE`, the FSRM service is enabled and monitor file operations according to
    /// configured policies. When `FALSE` or omitted, FSRM is disabled. The default
    /// value is `FALSE`.
    fsrm_service_enabled: bool,

    pub const json_field_names = .{
        .event_log_destination = "EventLogDestination",
        .fsrm_service_enabled = "FsrmServiceEnabled",
    };
};
