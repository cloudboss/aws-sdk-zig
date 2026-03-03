const Certificate = @import("certificate.zig").Certificate;
const DomainStatus = @import("domain_status.zig").DomainStatus;
const SubDomain = @import("sub_domain.zig").SubDomain;
const UpdateStatus = @import("update_status.zig").UpdateStatus;

/// Describes the association between a custom domain and an Amplify app.
pub const DomainAssociation = struct {
    /// Sets branch patterns for automatic subdomain creation.
    auto_sub_domain_creation_patterns: ?[]const []const u8 = null,

    /// The required AWS Identity and Access Management (IAM) service role for the
    /// Amazon
    /// Resource Name (ARN) for automatically creating subdomains.
    auto_sub_domain_iam_role: ?[]const u8 = null,

    /// Describes the SSL/TLS certificate for the domain association. This can be
    /// your own
    /// custom certificate or the default certificate that Amplify provisions for
    /// you.
    ///
    /// If you are updating your domain to use a different certificate,
    /// `certificate` points to the new certificate that is being created instead
    /// of the current active certificate. Otherwise, `certificate` points to the
    /// current active certificate.
    certificate: ?Certificate = null,

    /// The DNS record for certificate verification.
    certificate_verification_dns_record: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the domain association.
    domain_association_arn: []const u8,

    /// The name of the domain.
    domain_name: []const u8,

    /// The current status of the domain association.
    domain_status: DomainStatus,

    /// Enables the automated creation of subdomains for branches.
    enable_auto_sub_domain: bool,

    /// Additional information that describes why the domain association is in the
    /// current
    /// state.
    status_reason: []const u8,

    /// The subdomains for the domain association.
    sub_domains: []const SubDomain,

    /// The status of the domain update operation that is currently in progress. The
    /// following
    /// list describes the valid update states.
    ///
    /// **REQUESTING_CERTIFICATE**
    ///
    /// The certificate is in the process of being updated.
    ///
    /// **PENDING_VERIFICATION**
    ///
    /// Indicates that an Amplify managed certificate is in the
    /// process of being verified. This occurs during the creation of a custom
    /// domain or when a custom domain is updated to use a managed
    /// certificate.
    ///
    /// **IMPORTING_CUSTOM_CERTIFICATE**
    ///
    /// Indicates that an Amplify custom certificate is in the
    /// process of being imported. This occurs during the creation of a custom
    /// domain or when a custom domain is updated to use a custom
    /// certificate.
    ///
    /// **PENDING_DEPLOYMENT**
    ///
    /// Indicates that the subdomain or certificate changes are being
    /// propagated.
    ///
    /// **AWAITING_APP_CNAME**
    ///
    /// Amplify is waiting for CNAME records corresponding to
    /// subdomains to be propagated. If your custom domain is on Route 53,
    /// Amplify handles this for you automatically. For more
    /// information about custom domains, see [Setting up custom
    /// domains](https://docs.aws.amazon.com/amplify/latest/userguide/custom-domains.html) in the *Amplify Hosting User
    /// Guide*.
    ///
    /// **UPDATE_COMPLETE**
    ///
    /// The certificate has been associated with a domain.
    ///
    /// **UPDATE_FAILED**
    ///
    /// The certificate has failed to be provisioned or associated, and there is
    /// no existing active certificate to roll back to.
    update_status: ?UpdateStatus = null,

    pub const json_field_names = .{
        .auto_sub_domain_creation_patterns = "autoSubDomainCreationPatterns",
        .auto_sub_domain_iam_role = "autoSubDomainIAMRole",
        .certificate = "certificate",
        .certificate_verification_dns_record = "certificateVerificationDNSRecord",
        .domain_association_arn = "domainAssociationArn",
        .domain_name = "domainName",
        .domain_status = "domainStatus",
        .enable_auto_sub_domain = "enableAutoSubDomain",
        .status_reason = "statusReason",
        .sub_domains = "subDomains",
        .update_status = "updateStatus",
    };
};
