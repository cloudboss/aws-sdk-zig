/// Information about logs built to an S3 bucket for a build project.
pub const AwsCodeBuildProjectLogsConfigS3LogsDetails = struct {
    /// Whether to disable encryption of the S3 build log output.
    encryption_disabled: ?bool,

    /// The ARN of the S3 bucket and the path prefix for S3 logs.
    location: ?[]const u8,

    /// The current status of the S3 build logs.
    status: ?[]const u8,

    pub const json_field_names = .{
        .encryption_disabled = "EncryptionDisabled",
        .location = "Location",
        .status = "Status",
    };
};
