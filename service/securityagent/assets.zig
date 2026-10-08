const Actor = @import("actor.zig").Actor;
const DocumentInfo = @import("document_info.zig").DocumentInfo;
const Endpoint = @import("endpoint.zig").Endpoint;
const IntegratedRepository = @import("integrated_repository.zig").IntegratedRepository;
const SourceCodeRepository = @import("source_code_repository.zig").SourceCodeRepository;
const TrustedCaCertificate = @import("trusted_ca_certificate.zig").TrustedCaCertificate;

/// The collection of assets used in a pentest configuration, including
/// endpoints, actors, documents, source code repositories, and integrated
/// repositories.
pub const Assets = struct {
    /// The list of actors used during penetration testing.
    actors: ?[]const Actor = null,

    /// The list of documents that provide context for the pentest.
    documents: ?[]const DocumentInfo = null,

    /// The list of endpoints to test during the pentest.
    endpoints: ?[]const Endpoint = null,

    /// The list of integrated repositories associated with the pentest.
    integrated_repositories: ?[]const IntegratedRepository = null,

    /// The list of source code repositories to analyze during the pentest.
    source_code: ?[]const SourceCodeRepository = null,

    /// The trust anchors used to validate target endpoint TLS certificates. Provide
    /// these for endpoints served by a private or internal certificate authority
    /// (CA), an intermediate CA, or a self-signed certificate.
    trusted_ca_certificates: ?[]const TrustedCaCertificate = null,

    pub const json_field_names = .{
        .actors = "actors",
        .documents = "documents",
        .endpoints = "endpoints",
        .integrated_repositories = "integratedRepositories",
        .source_code = "sourceCode",
        .trusted_ca_certificates = "trustedCaCertificates",
    };
};
