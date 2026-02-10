const NatGatewayAttachedAppliance = @import("nat_gateway_attached_appliance.zig").NatGatewayAttachedAppliance;
const AutoProvisionZonesState = @import("auto_provision_zones_state.zig").AutoProvisionZonesState;
const AutoScalingIpsState = @import("auto_scaling_ips_state.zig").AutoScalingIpsState;
const AvailabilityMode = @import("availability_mode.zig").AvailabilityMode;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const NatGatewayAddress = @import("nat_gateway_address.zig").NatGatewayAddress;
const ProvisionedBandwidth = @import("provisioned_bandwidth.zig").ProvisionedBandwidth;
const NatGatewayState = @import("nat_gateway_state.zig").NatGatewayState;
const Tag = @import("tag.zig").Tag;

/// Describes a NAT gateway.
pub const NatGateway = struct {
    /// The proxy appliances attached to the NAT Gateway for filtering and
    /// inspecting traffic to prevent data exfiltration.
    attached_appliances: ?[]const NatGatewayAttachedAppliance,

    /// For regional NAT gateways only: Indicates whether Amazon Web Services
    /// automatically manages AZ coverage. When enabled, the NAT gateway associates
    /// EIPs in all AZs where your VPC has subnets to handle outbound NAT traffic,
    /// expands to new AZs when you create subnets there, and retracts from AZs
    /// where you've removed all subnets. When disabled, you must manually manage
    /// which AZs the NAT gateway supports and their corresponding EIPs.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    auto_provision_zones: ?AutoProvisionZonesState,

    /// For regional NAT gateways only: Indicates whether Amazon Web Services
    /// automatically allocates additional Elastic IP addresses (EIPs) in an AZ when
    /// the NAT gateway needs more ports due to increased concurrent connections to
    /// a single destination from that AZ.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    auto_scaling_ips: ?AutoScalingIpsState,

    /// Indicates whether this is a zonal (single-AZ) or regional (multi-AZ) NAT
    /// gateway.
    ///
    /// A zonal NAT gateway is a NAT Gateway that provides redundancy and
    /// scalability within a single availability zone. A regional NAT gateway is a
    /// single NAT Gateway that works across multiple availability zones (AZs) in
    /// your VPC, providing redundancy, scalability and availability across all the
    /// AZs in a Region.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    availability_mode: ?AvailabilityMode,

    /// Indicates whether the NAT gateway supports public or private connectivity.
    connectivity_type: ?ConnectivityType,

    /// The date and time the NAT gateway was created.
    create_time: ?i64,

    /// The date and time the NAT gateway was deleted, if applicable.
    delete_time: ?i64,

    /// If the NAT gateway could not be created, specifies the error code for the
    /// failure.
    /// (`InsufficientFreeAddressesInSubnet` | `Gateway.NotAttached` |
    /// `InvalidAllocationID.NotFound` | `Resource.AlreadyAssociated` |
    /// `InternalError` | `InvalidSubnetID.NotFound`)
    failure_code: ?[]const u8,

    /// If the NAT gateway could not be created, specifies the error message for the
    /// failure, that corresponds to the error code.
    ///
    /// * For InsufficientFreeAddressesInSubnet: "Subnet has insufficient free
    ///   addresses to create this NAT gateway"
    ///
    /// * For Gateway.NotAttached: "Network vpc-xxxxxxxx has no Internet gateway
    ///   attached"
    ///
    /// * For InvalidAllocationID.NotFound: "Elastic IP address eipalloc-xxxxxxxx
    ///   could not be associated with this NAT gateway"
    ///
    /// * For Resource.AlreadyAssociated: "Elastic IP address eipalloc-xxxxxxxx is
    ///   already associated"
    ///
    /// * For InternalError: "Network interface eni-xxxxxxxx, created and used
    ///   internally by this NAT gateway is in an invalid state. Please try again."
    ///
    /// * For InvalidSubnetID.NotFound: "The specified subnet subnet-xxxxxxxx does
    ///   not exist or could not be found."
    failure_message: ?[]const u8,

    /// Information about the IP addresses and network interface associated with the
    /// NAT gateway.
    nat_gateway_addresses: ?[]const NatGatewayAddress,

    /// The ID of the NAT gateway.
    nat_gateway_id: ?[]const u8,

    /// Reserved. If you need to sustain traffic greater than the [documented
    /// limits](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html#vpc-limits-gateways),
    /// contact Amazon Web Services Support.
    provisioned_bandwidth: ?ProvisionedBandwidth,

    /// For regional NAT gateways only, this is the ID of the NAT gateway.
    route_table_id: ?[]const u8,

    /// The state of the NAT gateway.
    ///
    /// * `pending`: The NAT gateway is being created and is not ready to process
    /// traffic.
    ///
    /// * `failed`: The NAT gateway could not be created. Check the
    /// `failureCode` and `failureMessage` fields for the reason.
    ///
    /// * `available`: The NAT gateway is able to process traffic. This status
    ///   remains
    /// until you delete the NAT gateway, and does not indicate the health of the
    /// NAT gateway.
    ///
    /// * `deleting`: The NAT gateway is in the process of being terminated and may
    /// still be processing traffic.
    ///
    /// * `deleted`: The NAT gateway has been terminated and is no longer processing
    /// traffic.
    state: ?NatGatewayState,

    /// The ID of the subnet in which the NAT gateway is located.
    subnet_id: ?[]const u8,

    /// The tags for the NAT gateway.
    tags: ?[]const Tag,

    /// The ID of the VPC in which the NAT gateway is located.
    vpc_id: ?[]const u8,
};
