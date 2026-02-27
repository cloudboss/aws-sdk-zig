/// The details of the log provider for a third-party custom source.
pub const CustomLogSourceProvider = struct {
    /// The location of the partition in the Amazon S3 bucket for Security Lake.
    location: ?[]const u8,

    /// The ARN of the IAM role to be used by the entity putting logs into your
    /// custom source partition. Security Lake will apply the correct access
    /// policies to this role, but
    /// you must first manually create the trust policy for this role. The IAM role
    /// name must start with the text 'Security Lake'. The IAM role must trust the
    /// `logProviderAccountId` to assume the role.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .location = "location",
        .role_arn = "roleArn",
    };
};
