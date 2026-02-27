/// The Identity and Access Management (IAM) configuration.
pub const AwsIamConfig = struct {
    /// The signing Amazon Web Services Region for IAM authorization.
    signing_region: ?[]const u8,

    /// The signing service name for IAM authorization.
    signing_service_name: ?[]const u8,

    pub const json_field_names = .{
        .signing_region = "signingRegion",
        .signing_service_name = "signingServiceName",
    };
};
