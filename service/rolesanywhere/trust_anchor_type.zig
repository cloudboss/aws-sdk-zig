pub const TrustAnchorType = enum {
    aws_acm_pca,
    certificate_bundle,
    self_signed_repository,

    pub const json_field_names = .{
        .aws_acm_pca = "AWS_ACM_PCA",
        .certificate_bundle = "CERTIFICATE_BUNDLE",
        .self_signed_repository = "SELF_SIGNED_REPOSITORY",
    };
};
