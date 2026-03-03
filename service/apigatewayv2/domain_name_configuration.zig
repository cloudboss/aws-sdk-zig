const DomainNameStatus = @import("domain_name_status.zig").DomainNameStatus;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

/// The domain name configuration.
pub const DomainNameConfiguration = struct {
    /// A domain name for the API.
    api_gateway_domain_name: ?[]const u8 = null,

    /// An AWS-managed certificate that will be used by the edge-optimized endpoint
    /// for this domain name. AWS Certificate Manager is the only supported source.
    certificate_arn: ?[]const u8 = null,

    /// The user-friendly name of the certificate that will be used by the
    /// edge-optimized endpoint for this domain name.
    certificate_name: ?[]const u8 = null,

    /// The timestamp when the certificate that was used by edge-optimized endpoint
    /// for this domain name was uploaded.
    certificate_upload_date: ?i64 = null,

    /// The status of the domain name migration. The valid values are AVAILABLE,
    /// UPDATING, PENDING_CERTIFICATE_REIMPORT, and PENDING_OWNERSHIP_VERIFICATION.
    /// If the status is UPDATING, the domain cannot be modified further until the
    /// existing operation is complete. If it is AVAILABLE, the domain can be
    /// updated.
    domain_name_status: ?DomainNameStatus = null,

    /// An optional text message containing detailed information about status of the
    /// domain name migration.
    domain_name_status_message: ?[]const u8 = null,

    /// The endpoint type.
    endpoint_type: ?EndpointType = null,

    /// The Amazon Route 53 Hosted Zone ID of the endpoint.
    hosted_zone_id: ?[]const u8 = null,

    /// The IP address types that can invoke the domain name. Use ipv4 to allow only
    /// IPv4 addresses to invoke your domain name, or use dualstack to allow both
    /// IPv4 and IPv6 addresses to invoke your domain name.
    ip_address_type: ?IpAddressType = null,

    /// The ARN of the public certificate issued by ACM to validate ownership of
    /// your custom domain. Only required when configuring mutual TLS and using an
    /// ACM imported or private CA certificate ARN as the regionalCertificateArn
    ownership_verification_certificate_arn: ?[]const u8 = null,

    /// The Transport Layer Security (TLS) version of the security policy for this
    /// domain name. The valid values are TLS_1_0 and TLS_1_2.
    security_policy: ?SecurityPolicy = null,

    pub const json_field_names = .{
        .api_gateway_domain_name = "ApiGatewayDomainName",
        .certificate_arn = "CertificateArn",
        .certificate_name = "CertificateName",
        .certificate_upload_date = "CertificateUploadDate",
        .domain_name_status = "DomainNameStatus",
        .domain_name_status_message = "DomainNameStatusMessage",
        .endpoint_type = "EndpointType",
        .hosted_zone_id = "HostedZoneId",
        .ip_address_type = "IpAddressType",
        .ownership_verification_certificate_arn = "OwnershipVerificationCertificateArn",
        .security_policy = "SecurityPolicy",
    };
};
