/// The certificate root authority that secures your service.
pub const ServiceConnectTlsCertificateAuthority = struct {
    /// The ARN of the Amazon
    /// Web Services Private Certificate Authority certificate.
    aws_pca_authority_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_pca_authority_arn = "awsPcaAuthorityArn",
    };
};
