/// Describes a warning that occurred during an Asset Bundle import job.
pub const AssetBundleImportJobWarning = struct {
    /// The ARN of the resource that the warning occurred for.
    arn: ?[]const u8,

    /// A description of the warning that occurred during an Asset Bundle import
    /// job.
    message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .message = "Message",
    };
};
