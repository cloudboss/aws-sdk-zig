/// Contains information about the domain names that you want ACM to use to send
/// you emails that enable you to validate domain ownership.
pub const DomainValidationOption = struct {
    /// A fully qualified domain name (FQDN) in the certificate request.
    domain_name: []const u8,

    /// The domain name that you want ACM to use to send you validation emails. This
    /// domain name is the suffix of the email addresses that you want ACM to use.
    /// This must be the same as the `DomainName` value or a superdomain of the
    /// `DomainName` value. For example, if you request a certificate for
    /// `testing.example.com`, you can specify `example.com` for this value. In that
    /// case, ACM sends domain validation emails to the following five addresses:
    ///
    /// * admin@example.com
    /// * administrator@example.com
    /// * hostmaster@example.com
    /// * postmaster@example.com
    /// * webmaster@example.com
    validation_domain: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .validation_domain = "ValidationDomain",
    };
};
