/// Read-only metadata for IAM-based connections, containing role and source ARN
/// information.
pub const ReadIamConnectionMetadata = struct {
    /// The Amazon Resource Name (ARN) of the IAM role to assume for authentication.
    role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the source resource for IAM
    /// authentication.
    source_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .source_arn = "SourceArn",
    };
};
