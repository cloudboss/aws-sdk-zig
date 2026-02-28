const CertificateType = @import("certificate_type.zig").CertificateType;

/// The type of SSL/TLS certificate to use for your custom domain. If a
/// certificate type
/// isn't specified, Amplify uses the default `AMPLIFY_MANAGED`
/// certificate.
pub const CertificateSettings = struct {
    /// The Amazon resource name (ARN) for the custom certificate that you have
    /// already added
    /// to Certificate Manager in your Amazon Web Services account.
    ///
    /// This field is required only when the certificate type is `CUSTOM`.
    custom_certificate_arn: ?[]const u8,

    /// The certificate type.
    ///
    /// Specify `AMPLIFY_MANAGED` to use the default certificate that Amplify
    /// provisions for you.
    ///
    /// Specify `CUSTOM` to use your own certificate that you have already added to
    /// Certificate Manager in your Amazon Web Services account. Make sure you
    /// request (or
    /// import) the certificate in the US East (N. Virginia) Region (us-east-1). For
    /// more
    /// information about using ACM, see [Importing certificates into
    /// Certificate
    /// Manager](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *ACM User
    /// guide*.
    @"type": CertificateType,

    pub const json_field_names = .{
        .custom_certificate_arn = "customCertificateArn",
        .@"type" = "type",
    };
};
