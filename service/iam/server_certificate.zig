const ServerCertificateMetadata = @import("server_certificate_metadata.zig").ServerCertificateMetadata;
const Tag = @import("tag.zig").Tag;

/// Contains information about a server certificate.
///
/// This data type is used as a response element in the
/// [GetServerCertificate](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServerCertificate.html)
/// operation.
pub const ServerCertificate = struct {
    /// The contents of the public key certificate.
    certificate_body: []const u8,

    /// The contents of the public key certificate chain.
    certificate_chain: ?[]const u8 = null,

    /// The meta information of the server certificate, such as its name, path, ID,
    /// and
    /// ARN.
    server_certificate_metadata: ServerCertificateMetadata,

    /// A list of tags that are attached to the server certificate. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,
};
