/// The source of a trusted CA certificate. Exactly one member must be set.
pub const CaCertificateSource = union(enum) {
    /// The artifact ID of an uploaded certificate file.
    artifact_id: ?[]const u8,
    /// A PEM-encoded X.509 certificate supplied inline.
    inline_pem: ?[]const u8,
    /// The Amazon S3 location URI of a customer-staged certificate.
    s_3_location: ?[]const u8,

    pub const json_field_names = .{
        .artifact_id = "artifactId",
        .inline_pem = "inlinePem",
        .s_3_location = "s3Location",
    };
};
