/// Configuration of storage locations for the Amazon SageMaker Debugger
/// TensorBoard output data.
pub const TensorBoardOutputConfig = struct {
    /// Path to local storage location for tensorBoard output. Defaults to
    /// `/opt/ml/output/tensorboard`.
    local_path: ?[]const u8,

    /// Path to Amazon S3 storage location for TensorBoard output.
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .local_path = "LocalPath",
        .s3_output_path = "S3OutputPath",
    };
};
