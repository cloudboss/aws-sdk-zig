const aws = @import("aws");

const DomainNameStatus = @import("domain_name_status.zig").DomainNameStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;
const RoutingMode = @import("routing_mode.zig").RoutingMode;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

/// Represents a custom domain name as a user-friendly host name of an API
/// (RestApi).
pub const DomainName = struct {
    /// The reference to an Amazon Web Services-managed certificate that will be
    /// used by edge-optimized endpoint or private endpoint for this domain name.
    /// Certificate Manager is the only supported source.
    certificate_arn: ?[]const u8,

    /// The name of the certificate that will be used by edge-optimized endpoint or
    /// private endpoint for this domain name.
    certificate_name: ?[]const u8,

    /// The timestamp when the certificate that was used by edge-optimized endpoint
    /// or private endpoint for this domain name was uploaded.
    certificate_upload_date: ?i64,

    /// The domain name of the Amazon CloudFront distribution associated with this
    /// custom domain name for an edge-optimized endpoint. You set up this
    /// association when adding a DNS record pointing the custom domain name to this
    /// distribution name. For more information about CloudFront distributions, see
    /// the Amazon CloudFront documentation.
    distribution_domain_name: ?[]const u8,

    /// The region-agnostic Amazon Route 53 Hosted Zone ID of the edge-optimized
    /// endpoint. The valid value is `Z2FDTNDATAQYW2` for all the regions. For more
    /// information, see Set up a Regional Custom Domain Name and AWS Regions and
    /// Endpoints for API Gateway.
    distribution_hosted_zone_id: ?[]const u8,

    /// The custom domain name as an API host name, for example,
    /// `my-api.example.com`.
    domain_name: ?[]const u8,

    /// The ARN of the domain name.
    domain_name_arn: ?[]const u8,

    /// The identifier for the domain name resource. Supported only for private
    /// custom domain names.
    domain_name_id: ?[]const u8,

    /// The status of the DomainName migration. The valid values are `AVAILABLE` and
    /// `UPDATING`. If the status is `UPDATING`, the domain cannot be modified
    /// further until the existing operation is complete. If it is `AVAILABLE`, the
    /// domain can be updated.
    domain_name_status: ?DomainNameStatus,

    /// An optional text message containing detailed information about status of the
    /// DomainName migration.
    domain_name_status_message: ?[]const u8,

    /// The endpoint access mode of the DomainName.
    endpoint_access_mode: ?EndpointAccessMode,

    /// The endpoint configuration of this DomainName showing the endpoint types and
    /// IP address types of the domain name.
    endpoint_configuration: ?EndpointConfiguration,

    /// A stringified JSON policy document that applies to the API Gateway
    /// Management service for this DomainName. This policy document controls access
    /// for access association sources to create domain name access associations
    /// with this DomainName. Supported only for private custom domain names.
    management_policy: ?[]const u8,

    /// The mutual TLS authentication configuration for a custom domain name. If
    /// specified, API Gateway
    /// performs two-way authentication between the client and the server. Clients
    /// must present a
    /// trusted certificate to access your API.
    mutual_tls_authentication: ?MutualTlsAuthentication,

    /// The ARN of the public certificate issued by ACM to validate ownership of
    /// your custom
    /// domain. Only required when configuring mutual TLS and using an ACM imported
    /// or private CA
    /// certificate ARN as the regionalCertificateArn.
    ownership_verification_certificate_arn: ?[]const u8,

    /// A stringified JSON policy document that applies to the `execute-api` service
    /// for this DomainName regardless of the caller and Method
    /// configuration. Supported only for private custom
    /// domain names.
    policy: ?[]const u8,

    /// The reference to an Amazon Web Services-managed certificate that will be
    /// used for validating the regional domain name. Certificate Manager is the
    /// only supported source.
    regional_certificate_arn: ?[]const u8,

    /// The name of the certificate that will be used for validating the regional
    /// domain name.
    regional_certificate_name: ?[]const u8,

    /// The domain name associated with the regional endpoint for this custom domain
    /// name. You set up this association by adding a DNS record that points the
    /// custom domain name to this regional domain name. The regional domain name is
    /// returned by API Gateway when you create a regional endpoint.
    regional_domain_name: ?[]const u8,

    /// The region-specific Amazon Route 53 Hosted Zone ID of the regional endpoint.
    /// For more information, see Set up a Regional Custom Domain Name and AWS
    /// Regions and Endpoints for API Gateway.
    regional_hosted_zone_id: ?[]const u8,

    /// The routing mode for this domain name. The routing mode determines how API
    /// Gateway sends traffic from your custom domain name to your private APIs.
    routing_mode: ?RoutingMode,

    /// The Transport Layer Security (TLS) version + cipher suite for this
    /// DomainName.
    security_policy: ?SecurityPolicy,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_name = "certificateName",
        .certificate_upload_date = "certificateUploadDate",
        .distribution_domain_name = "distributionDomainName",
        .distribution_hosted_zone_id = "distributionHostedZoneId",
        .domain_name = "domainName",
        .domain_name_arn = "domainNameArn",
        .domain_name_id = "domainNameId",
        .domain_name_status = "domainNameStatus",
        .domain_name_status_message = "domainNameStatusMessage",
        .endpoint_access_mode = "endpointAccessMode",
        .endpoint_configuration = "endpointConfiguration",
        .management_policy = "managementPolicy",
        .mutual_tls_authentication = "mutualTlsAuthentication",
        .ownership_verification_certificate_arn = "ownershipVerificationCertificateArn",
        .policy = "policy",
        .regional_certificate_arn = "regionalCertificateArn",
        .regional_certificate_name = "regionalCertificateName",
        .regional_domain_name = "regionalDomainName",
        .regional_hosted_zone_id = "regionalHostedZoneId",
        .routing_mode = "routingMode",
        .security_policy = "securityPolicy",
        .tags = "tags",
    };
};
