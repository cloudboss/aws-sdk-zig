const aws = @import("aws");

const InstanceHealthSummary = @import("instance_health_summary.zig").InstanceHealthSummary;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const LoadBalancerProtocol = @import("load_balancer_protocol.zig").LoadBalancerProtocol;
const ResourceType = @import("resource_type.zig").ResourceType;
const LoadBalancerState = @import("load_balancer_state.zig").LoadBalancerState;
const Tag = @import("tag.zig").Tag;
const LoadBalancerTlsCertificateSummary = @import("load_balancer_tls_certificate_summary.zig").LoadBalancerTlsCertificateSummary;

/// Describes a load balancer.
pub const LoadBalancer = struct {
    /// The Amazon Resource Name (ARN) of the load balancer.
    arn: ?[]const u8,

    /// A string to string map of the configuration options for your load balancer.
    /// Valid values
    /// are listed below.
    configuration_options: ?[]const aws.map.StringMapEntry,

    /// The date when your load balancer was created.
    created_at: ?i64,

    /// The DNS name of your Lightsail load balancer.
    dns_name: ?[]const u8,

    /// The path you specified to perform your health checks. If no path is
    /// specified, the load
    /// balancer tries to make a request to the default (root) page.
    health_check_path: ?[]const u8,

    /// A Boolean value that indicates whether HTTPS redirection is enabled for the
    /// load
    /// balancer.
    https_redirection_enabled: ?bool,

    /// An array of InstanceHealthSummary objects describing the health of the load
    /// balancer.
    instance_health_summary: ?[]const InstanceHealthSummary,

    /// The port where the load balancer will direct traffic to your Lightsail
    /// instances. For
    /// HTTP traffic, it's port 80. For HTTPS traffic, it's port 443.
    instance_port: ?i32,

    /// The IP address type of the load balancer.
    ///
    /// The possible values are `ipv4` for IPv4 only, `ipv6` for IPv6 only,
    /// and `dualstack` for IPv4 and IPv6.
    ip_address_type: ?IpAddressType,

    /// The AWS Region where your load balancer was created (`us-east-2a`).
    /// Lightsail
    /// automatically creates your load balancer across Availability Zones.
    location: ?ResourceLocation,

    /// The name of the load balancer (`my-load-balancer`).
    name: ?[]const u8,

    /// The protocol you have enabled for your load balancer. Valid values are
    /// below.
    ///
    /// You can't just have `HTTP_HTTPS`, but you can have just
    /// `HTTP`.
    protocol: ?LoadBalancerProtocol,

    /// An array of public port settings for your load balancer. For HTTP, use port
    /// 80. For HTTPS,
    /// use port 443.
    public_ports: ?[]const i32,

    /// The resource type (`LoadBalancer`.
    resource_type: ?ResourceType,

    /// The status of your load balancer. Valid values are below.
    state: ?LoadBalancerState,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// your Lightsail load balancer. This code enables our support team to look up
    /// your Lightsail
    /// information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    /// An array of LoadBalancerTlsCertificateSummary objects that provide
    /// additional information
    /// about the SSL/TLS certificates. For example, if `true`, the certificate is
    /// attached
    /// to the load balancer.
    tls_certificate_summaries: ?[]const LoadBalancerTlsCertificateSummary,

    /// The name of the TLS security policy for the load balancer.
    tls_policy_name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .configuration_options = "configurationOptions",
        .created_at = "createdAt",
        .dns_name = "dnsName",
        .health_check_path = "healthCheckPath",
        .https_redirection_enabled = "httpsRedirectionEnabled",
        .instance_health_summary = "instanceHealthSummary",
        .instance_port = "instancePort",
        .ip_address_type = "ipAddressType",
        .location = "location",
        .name = "name",
        .protocol = "protocol",
        .public_ports = "publicPorts",
        .resource_type = "resourceType",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
        .tls_certificate_summaries = "tlsCertificateSummaries",
        .tls_policy_name = "tlsPolicyName",
    };
};
