/// Describes an error that occurred during an Asset Bundle export job.
pub const AssetBundleExportJobError = struct {
    /// The ARN of the resource whose processing caused an error.
    arn: ?[]const u8,

    /// A description of the error.
    message: ?[]const u8,

    /// The specific error type of the error that occurred.
    type: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .message = "Message",
        .type = "Type",
    };
};
