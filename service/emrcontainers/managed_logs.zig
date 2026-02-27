const AllowAWSToRetainLogs = @import("allow_aws_to_retain_logs.zig").AllowAWSToRetainLogs;

/// The entity that provides configuration control over managed logs.
pub const ManagedLogs = struct {
    /// Determines whether Amazon Web Services can retain logs.
    allow_aws_to_retain_logs: ?AllowAWSToRetainLogs,

    /// The Amazon resource name (ARN) of the encryption key for logs.
    encryption_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .allow_aws_to_retain_logs = "allowAWSToRetainLogs",
        .encryption_key_arn = "encryptionKeyArn",
    };
};
