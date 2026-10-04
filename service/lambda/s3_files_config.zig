const DirectS3Read = @import("direct_s3_read.zig").DirectS3Read;

/// Setting controls how your function accesses data from an Amazon S3 file
/// system.
pub const S3FilesConfig = struct {
    /// Specifies if a function reads from the file system for the lowest latency,
    /// or through Amazon S3 Files feature "direct Amazon S3 bucket reads" for the
    /// highest throughput. Valid values:
    ///
    /// * `AUTO` (default) – Direct reads are active for functions you configure
    ///   with 512 MB or more of memory.
    /// * `ENABLED` – Enforces all reads are directly from the Amazon S3 bucket,
    ///   regardless of available memory (less than 512 MB).
    /// * `DISABLED` – Routes all reads through the file system, regardless of
    ///   memory configuration.
    ///
    /// To use direct reads, you must grant the execution role the `s3:GetObject`
    /// and `s3:GetObjectVersion` permissions. If a direct read fails, Lambda
    /// automatically falls back to reading through the file system.
    direct_s3_read: ?DirectS3Read = null,

    pub const json_field_names = .{
        .direct_s3_read = "DirectS3Read",
    };
};
