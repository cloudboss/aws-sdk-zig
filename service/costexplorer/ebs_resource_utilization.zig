/// The EBS field that contains a list of EBS metrics that are associated with
/// the current
/// instance.
pub const EBSResourceUtilization = struct {
    /// The maximum size of read operations per second
    ebs_read_bytes_per_second: ?[]const u8,

    /// The maximum number of read operations per second.
    ebs_read_ops_per_second: ?[]const u8,

    /// The maximum size of write operations per second.
    ebs_write_bytes_per_second: ?[]const u8,

    /// The maximum number of write operations per second.
    ebs_write_ops_per_second: ?[]const u8,

    pub const json_field_names = .{
        .ebs_read_bytes_per_second = "EbsReadBytesPerSecond",
        .ebs_read_ops_per_second = "EbsReadOpsPerSecond",
        .ebs_write_bytes_per_second = "EbsWriteBytesPerSecond",
        .ebs_write_ops_per_second = "EbsWriteOpsPerSecond",
    };
};
