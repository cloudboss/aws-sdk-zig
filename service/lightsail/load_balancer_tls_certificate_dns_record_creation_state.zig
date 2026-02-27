const LoadBalancerTlsCertificateDnsRecordCreationStateCode = @import("load_balancer_tls_certificate_dns_record_creation_state_code.zig").LoadBalancerTlsCertificateDnsRecordCreationStateCode;

/// An object that describes the state of the canonical name (CNAME) records
/// that are
/// automatically added by Lightsail to the DNS of the domain to validate domain
/// ownership.
pub const LoadBalancerTlsCertificateDnsRecordCreationState = struct {
    /// The status code for the automated DNS record creation.
    ///
    /// Following are the possible values:
    ///
    /// * `SUCCEEDED` - The validation records were successfully added.
    ///
    /// * `STARTED` - The automatic DNS record creation has started.
    ///
    /// * `FAILED` - The validation record addition failed.
    code: ?LoadBalancerTlsCertificateDnsRecordCreationStateCode,

    /// The message that describes the reason for the status code.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
