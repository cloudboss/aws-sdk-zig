/// Contains information about the output location for managed spot training
/// checkpoint data.
pub const CheckpointConfig = struct {
    /// (Optional) The local directory where checkpoints are written. The default
    /// directory is `/opt/ml/checkpoints/`.
    local_path: ?[]const u8,

    /// Identifies the S3 path where you want SageMaker to store checkpoints. For
    /// example, `s3://bucket-name/key-name-prefix`.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .local_path = "LocalPath",
        .s3_uri = "S3Uri",
    };
};
