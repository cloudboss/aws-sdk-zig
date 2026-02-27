/// For more information, see [Signature Version 4 signing
/// process](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
pub const SigV4Authorization = struct {
    /// The ARN of the signing role.
    role_arn: []const u8,

    /// The service name to use while signing with Sig V4.
    service_name: []const u8,

    /// The signing region.
    signing_region: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .service_name = "serviceName",
        .signing_region = "signingRegion",
    };
};
