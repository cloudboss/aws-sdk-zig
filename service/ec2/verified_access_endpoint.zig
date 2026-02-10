const VerifiedAccessEndpointAttachmentType = @import("verified_access_endpoint_attachment_type.zig").VerifiedAccessEndpointAttachmentType;
const VerifiedAccessEndpointCidrOptions = @import("verified_access_endpoint_cidr_options.zig").VerifiedAccessEndpointCidrOptions;
const VerifiedAccessEndpointType = @import("verified_access_endpoint_type.zig").VerifiedAccessEndpointType;
const VerifiedAccessEndpointLoadBalancerOptions = @import("verified_access_endpoint_load_balancer_options.zig").VerifiedAccessEndpointLoadBalancerOptions;
const VerifiedAccessEndpointEniOptions = @import("verified_access_endpoint_eni_options.zig").VerifiedAccessEndpointEniOptions;
const VerifiedAccessEndpointRdsOptions = @import("verified_access_endpoint_rds_options.zig").VerifiedAccessEndpointRdsOptions;
const VerifiedAccessSseSpecificationResponse = @import("verified_access_sse_specification_response.zig").VerifiedAccessSseSpecificationResponse;
const VerifiedAccessEndpointStatus = @import("verified_access_endpoint_status.zig").VerifiedAccessEndpointStatus;
const Tag = @import("tag.zig").Tag;

/// An Amazon Web Services Verified Access endpoint specifies the application
/// that Amazon Web Services Verified Access provides access to. It must be
/// attached to an Amazon Web Services Verified Access group. An Amazon Web
/// Services Verified Access endpoint must also have an attached access policy
/// before you attached it to a group.
pub const VerifiedAccessEndpoint = struct {
    /// The DNS name for users to reach your application.
    application_domain: ?[]const u8,

    /// The type of attachment used to provide connectivity between the Amazon Web
    /// Services Verified Access endpoint and the
    /// application.
    attachment_type: ?VerifiedAccessEndpointAttachmentType,

    /// The options for a CIDR endpoint.
    cidr_options: ?VerifiedAccessEndpointCidrOptions,

    /// The creation time.
    creation_time: ?[]const u8,

    /// The deletion time.
    deletion_time: ?[]const u8,

    /// A description for the Amazon Web Services Verified Access endpoint.
    description: ?[]const u8,

    /// Returned if endpoint has a device trust provider attached.
    device_validation_domain: ?[]const u8,

    /// The ARN of a public TLS/SSL certificate imported into or created with ACM.
    domain_certificate_arn: ?[]const u8,

    /// A DNS name that is generated for the endpoint.
    endpoint_domain: ?[]const u8,

    /// The type of Amazon Web Services Verified Access endpoint. Incoming
    /// application requests will be sent to an IP
    /// address, load balancer or a network interface depending on the endpoint type
    /// specified.
    endpoint_type: ?VerifiedAccessEndpointType,

    /// The last updated time.
    last_updated_time: ?[]const u8,

    /// The load balancer details if creating the Amazon Web Services Verified
    /// Access endpoint as
    /// `load-balancer`type.
    load_balancer_options: ?VerifiedAccessEndpointLoadBalancerOptions,

    /// The options for network-interface type endpoint.
    network_interface_options: ?VerifiedAccessEndpointEniOptions,

    /// The options for an RDS endpoint.
    rds_options: ?VerifiedAccessEndpointRdsOptions,

    /// The IDs of the security groups for the endpoint.
    security_group_ids: ?[]const []const u8,

    /// The options in use for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationResponse,

    /// The endpoint status.
    status: ?VerifiedAccessEndpointStatus,

    /// The tags.
    tags: ?[]const Tag,

    /// The ID of the Amazon Web Services Verified Access endpoint.
    verified_access_endpoint_id: ?[]const u8,

    /// The ID of the Amazon Web Services Verified Access group.
    verified_access_group_id: ?[]const u8,

    /// The ID of the Amazon Web Services Verified Access instance.
    verified_access_instance_id: ?[]const u8,
};
