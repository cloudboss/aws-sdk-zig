/// Describes a warning that occurred during an Asset Bundle export job.
pub const AssetBundleExportJobWarning = struct {
    /// The ARN of the resource whose processing caused a warning.
    arn: ?[]const u8 = null,

    /// A description of the warning.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .message = "Message",
    };
};
