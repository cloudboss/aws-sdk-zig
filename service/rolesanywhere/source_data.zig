/// The data field of the trust anchor depending on its type.
pub const SourceData = union(enum) {
    /// The root certificate of the Private Certificate Authority specified by this
    /// ARN is used in trust validation for temporary credential requests. Included
    /// for trust anchors of type `AWS_ACM_PCA`.
    acm_pca_arn: ?[]const u8,
    /// The PEM-encoded data for the certificate anchor. Included for trust anchors
    /// of type `CERTIFICATE_BUNDLE`.
    x_509_certificate_data: ?[]const u8,

    pub const json_field_names = .{
        .acm_pca_arn = "acmPcaArn",
        .x_509_certificate_data = "x509CertificateData",
    };
};
