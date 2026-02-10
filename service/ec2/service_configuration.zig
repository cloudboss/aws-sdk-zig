const PayerResponsibility = @import("payer_responsibility.zig").PayerResponsibility;
const PrivateDnsNameConfiguration = @import("private_dns_name_configuration.zig").PrivateDnsNameConfiguration;
const ServiceState = @import("service_state.zig").ServiceState;
const ServiceTypeDetail = @import("service_type_detail.zig").ServiceTypeDetail;
const ServiceConnectivityType = @import("service_connectivity_type.zig").ServiceConnectivityType;
const SupportedRegionDetail = @import("supported_region_detail.zig").SupportedRegionDetail;
const Tag = @import("tag.zig").Tag;

/// Describes a service configuration for a VPC endpoint service.
pub const ServiceConfiguration = struct {
    /// Indicates whether requests from other Amazon Web Services accounts to create
    /// an endpoint to the service must first be accepted.
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

    /// The Amazon Resource Names (ARNs) of the Gateway Load Balancers for the
    /// service.
    gateway_load_balancer_arns: ?[]const []const u8,

    /// Indicates whether the service manages its VPC endpoints. Management of the
    /// service VPC
    /// endpoints using the VPC endpoint API is restricted.
    manages_vpc_endpoints: ?bool,

    /// The Amazon Resource Names (ARNs) of the Network Load Balancers for the
    /// service.
    network_load_balancer_arns: ?[]const []const u8,

    /// The payer responsibility.
    payer_responsibility: ?PayerResponsibility,

    /// The private DNS name for the service.
    private_dns_name: ?[]const u8,

    /// Information about the endpoint service private DNS name configuration.
    private_dns_name_configuration: ?PrivateDnsNameConfiguration,

    /// Indicates whether consumers can access the service from a Region other than
    /// the
    /// Region where the service is hosted.
    remote_access_enabled: ?bool,

    /// The ID of the service.
    service_id: ?[]const u8,

    /// The name of the service.
    service_name: ?[]const u8,

    /// The service state.
    service_state: ?ServiceState,

    /// The type of service.
    service_type: ?[]const ServiceTypeDetail,

    /// The supported IP address types.
    supported_ip_address_types: ?[]const ServiceConnectivityType,

    /// The supported Regions.
    supported_regions: ?[]const SupportedRegionDetail,

    /// The tags assigned to the service.
    tags: ?[]const Tag,
};
