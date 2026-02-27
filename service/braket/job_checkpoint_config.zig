/// Contains information about the output locations for hybrid job checkpoint
/// data.
pub const JobCheckpointConfig = struct {
    /// (Optional) The local directory where checkpoint data is stored. The default
    /// directory is `/opt/braket/checkpoints/`.
    local_path: ?[]const u8,

    /// Identifies the S3 path where you want Amazon Braket to store checkpoint
    /// data. For example, `s3://bucket-name/key-name-prefix`.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .local_path = "localPath",
        .s_3_uri = "s3Uri",
    };
};
