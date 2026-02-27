const DnsRecordCreationStateCode = @import("dns_record_creation_state_code.zig").DnsRecordCreationStateCode;

/// Describes the creation state of the canonical name (CNAME) records that are
/// automatically
/// added by Amazon Lightsail to the DNS of a domain to validate domain
/// ownership for
/// an SSL/TLS certificate.
///
/// When you create an SSL/TLS certificate for a Lightsail resource, you must
/// add a set of CNAME records to the DNS of the domains for the certificate to
/// validate that you
/// own the domains. Lightsail can automatically add the CNAME records to the
/// DNS
/// of the domain if the DNS zone for the domain exists within your Lightsail
/// account. If automatic record addition fails, or if you manage the DNS of
/// your domain using a
/// third-party service, then you must manually add the CNAME records to the DNS
/// of your domain.
/// For more information, see [Verify an SSL/TLS certificate in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/verify-tls-ssl-certificate-using-dns-cname-https) in the
/// *Amazon Lightsail Developer Guide*.
pub const DnsRecordCreationState = struct {
    /// The status code for the automated DNS record creation.
    ///
    /// Following are the possible values:
    ///
    /// * `SUCCEEDED` - The validation records were successfully added to the
    /// domain.
    ///
    /// * `STARTED` - The automatic DNS record creation has started.
    ///
    /// * `FAILED` - The validation records failed to be added to the domain.
    code: ?DnsRecordCreationStateCode,

    /// The message that describes the reason for the status code.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
