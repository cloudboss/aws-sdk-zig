const CaCertificatesBundleS3Location = @import("ca_certificates_bundle_s3_location.zig").CaCertificatesBundleS3Location;

/// A CA certificates bundle source.
pub const CaCertificatesBundleSource = union(enum) {
    /// The CA certificates bundle location in Amazon S3.
    ca_certificates_bundle_s3_location: ?CaCertificatesBundleS3Location,
};
