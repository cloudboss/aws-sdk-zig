/// The ACM certificate that is used to sign your code.
pub const SigningMaterial = struct {
    /// The Amazon Resource Name (ARN) of the certificates that is used to sign your
    /// code.
    certificate_arn: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
    };
};
