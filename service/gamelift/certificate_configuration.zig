const CertificateType = @import("certificate_type.zig").CertificateType;

/// Determines whether a TLS/SSL certificate is generated for a fleet. This
/// feature must
/// be enabled when creating the fleet. All instances in a fleet share the same
/// certificate.
/// The certificate can be retrieved by calling the [Amazon GameLift Servers
/// Server
/// SDK](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk.html) operation `GetInstanceCertificate`.
pub const CertificateConfiguration = struct {
    /// Indicates whether a TLS/SSL certificate is generated for a fleet.
    ///
    /// Valid values include:
    ///
    /// * **GENERATED** - Generate a TLS/SSL certificate
    /// for this fleet.
    ///
    /// * **DISABLED** - (default) Do not generate a
    /// TLS/SSL certificate for this fleet.
    certificate_type: CertificateType,

    pub const json_field_names = .{
        .certificate_type = "CertificateType",
    };
};
