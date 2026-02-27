const CompressionType = @import("compression_type.zig").CompressionType;

/// Contains information about algorithm scripts used for the Amazon Braket
/// hybrid job.
pub const ScriptModeConfig = struct {
    /// The type of compression used to store the algorithm scripts in Amazon S3
    /// storage.
    compression_type: ?CompressionType,

    /// The entry point in the algorithm scripts from where the execution begins in
    /// the hybrid job.
    entry_point: []const u8,

    /// The URI that specifies the S3 path to the algorithm scripts used by an
    /// Amazon Braket hybrid job.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .compression_type = "compressionType",
        .entry_point = "entryPoint",
        .s_3_uri = "s3Uri",
    };
};
