const aws = @import("aws");

/// Represents a client certificate used to configure client-side SSL
/// authentication while sending requests to the integration endpoint.
pub const ClientCertificate = struct {
    /// The identifier of the client certificate.
    client_certificate_id: ?[]const u8,

    /// The timestamp when the client certificate was created.
    created_date: ?i64,

    /// The description of the client certificate.
    description: ?[]const u8,

    /// The timestamp when the client certificate will expire.
    expiration_date: ?i64,

    /// The PEM-encoded public key of the client certificate, which can be used to
    /// configure certificate authentication in the integration endpoint .
    pem_encoded_certificate: ?[]const u8,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .client_certificate_id = "clientCertificateId",
        .created_date = "createdDate",
        .description = "description",
        .expiration_date = "expirationDate",
        .pem_encoded_certificate = "pemEncodedCertificate",
        .tags = "tags",
    };
};
