/// The entity representing certificate data generated for managed endpoint.
pub const Certificate = struct {
    /// The ARN of the certificate generated for managed endpoint.
    certificate_arn: ?[]const u8 = null,

    /// The base64 encoded PEM certificate data generated for managed endpoint.
    certificate_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_data = "certificateData",
    };
};
