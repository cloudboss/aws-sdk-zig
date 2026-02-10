const PayerResponsibility = @import("payer_responsibility.zig").PayerResponsibility;
const PrivateDnsDetails = @import("private_dns_details.zig").PrivateDnsDetails;
const DnsNameState = @import("dns_name_state.zig").DnsNameState;
const ServiceTypeDetail = @import("service_type_detail.zig").ServiceTypeDetail;
const ServiceConnectivityType = @import("service_connectivity_type.zig").ServiceConnectivityType;
const Tag = @import("tag.zig").Tag;

/// Describes a VPC endpoint service.
pub const ServiceDetail = struct {
    /// Indicates whether VPC endpoint connection requests to the service must be
    /// accepted by the service owner.
    acceptance_required: ?bool,

    /// The IDs of the Availability Zones in which the service is available.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified, but not
    /// both
    availability_zone_ids: ?[]const []const u8,

    /// The Availability Zones in which the service is available.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified, but not
    /// both
    availability_zones: ?[]const []const u8,

    /// The DNS names for the service.
    base_endpoint_dns_names: ?[]const []const u8,

    /// Indicates whether the service manages its VPC endpoints. Management of the
    /// service VPC
    /// endpoints using the VPC endpoint API is restricted.
    manages_vpc_endpoints: ?bool,

    /// The Amazon Web Services account ID of the service owner.
    owner: ?[]const u8,

    /// The payer responsibility.
    payer_responsibility: ?PayerResponsibility,

    /// The private DNS name for the service.
    private_dns_name: ?[]const u8,

    /// The private DNS names assigned to the VPC endpoint service.
    private_dns_names: ?[]const PrivateDnsDetails,

    /// The verification state of the VPC endpoint service.
    ///
    /// Consumers of the endpoint service cannot use the private name when the state
    /// is not `verified`.
    private_dns_name_verification_state: ?DnsNameState,

    /// The ID of the endpoint service.
    service_id: ?[]const u8,

    /// The name of the service.
    service_name: ?[]const u8,

    /// The Region where the service is hosted.
    service_region: ?[]const u8,

    /// The type of service.
    service_type: ?[]const ServiceTypeDetail,

    /// The supported IP address types.
    supported_ip_address_types: ?[]const ServiceConnectivityType,

    /// The tags assigned to the service.
    tags: ?[]const Tag,

    /// Indicates whether the service supports endpoint policies.
    vpc_endpoint_policy_supported: ?bool,
};
