/// The configuration for an IAM role credential provider that signs requests to
/// a registry record's source with Amazon Web Services Signature Version 4
/// (SigV4).
pub const RegistryRecordIamCredentialProvider = struct {
    /// The Amazon Web Services Region to use for request signing. If not specified,
    /// the Region is derived from the source URL hostname, falling back to the
    /// Region of the registry.
    region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to assume for request
    /// signing.
    role_arn: ?[]const u8 = null,

    /// The service name to use for request signing, such as execute-api.
    service: ?[]const u8 = null,

    pub const json_field_names = .{
        .region = "region",
        .role_arn = "roleArn",
        .service = "service",
    };
};
