const ClientCertificateRevocationListStatusCode = @import("client_certificate_revocation_list_status_code.zig").ClientCertificateRevocationListStatusCode;

/// Describes the state of a client certificate revocation list.
pub const ClientCertificateRevocationListStatus = struct {
    /// The state of the client certificate revocation list.
    code: ?ClientCertificateRevocationListStatusCode,

    /// A message about the status of the client certificate revocation list, if
    /// applicable.
    message: ?[]const u8,
};
