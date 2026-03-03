const AvailabilityZoneMapping = @import("availability_zone_mapping.zig").AvailabilityZoneMapping;
const EnabledAnalysisType = @import("enabled_analysis_type.zig").EnabledAnalysisType;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const Tag = @import("tag.zig").Tag;

/// A firewall defines the behavior of a firewall, the main VPC where the
/// firewall is used, the Availability Zones where the firewall can be used, and
/// one subnet to use for a firewall endpoint within each of the Availability
/// Zones. The Availability Zones are defined implicitly in the subnet
/// specifications.
///
/// In addition to the firewall endpoints that you define in this `Firewall`
/// specification, you can create firewall endpoints in `VpcEndpointAssociation`
/// resources for any VPC, in any Availability Zone where the firewall is
/// already in use.
///
/// The status of the firewall, for example whether it's ready to filter network
/// traffic,
/// is provided in the corresponding FirewallStatus. You can retrieve both
/// the firewall and firewall status by calling DescribeFirewall.
pub const Firewall = struct {
    /// A setting indicating whether the firewall is protected against changes to
    /// its Availability Zone configuration. When set to `TRUE`, you must first
    /// disable this protection before adding or removing Availability Zones.
    availability_zone_change_protection: bool = false,

    /// The Availability Zones where the firewall endpoints are created for a
    /// transit gateway-attached firewall. Each mapping specifies an Availability
    /// Zone where the firewall processes traffic.
    availability_zone_mappings: ?[]const AvailabilityZoneMapping = null,

    /// A flag indicating whether it is possible to delete the firewall. A setting
    /// of `TRUE` indicates
    /// that the firewall is protected against deletion. Use this setting to protect
    /// against
    /// accidentally deleting a firewall that is in use. When you create a firewall,
    /// the operation initializes this flag to `TRUE`.
    delete_protection: bool = false,

    /// A description of the firewall.
    description: ?[]const u8 = null,

    /// An optional setting indicating the specific traffic analysis types to enable
    /// on the firewall.
    enabled_analysis_types: ?[]const EnabledAnalysisType = null,

    /// A complex type that contains the Amazon Web Services KMS encryption
    /// configuration settings for your firewall.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// The unique identifier for the firewall.
    firewall_id: []const u8,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    firewall_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall policy.
    ///
    /// The relationship of firewall to firewall policy is many to one. Each
    /// firewall requires
    /// one firewall policy association, and you can use the same firewall policy
    /// for multiple
    /// firewalls.
    firewall_policy_arn: []const u8,

    /// A setting indicating whether the firewall is protected against a change to
    /// the firewall policy association.
    /// Use this setting to protect against
    /// accidentally modifying the firewall policy for a firewall that is in use.
    /// When you create a firewall, the operation initializes this setting to
    /// `TRUE`.
    firewall_policy_change_protection: bool = false,

    /// The number of `VpcEndpointAssociation` resources that use this firewall.
    number_of_associations: ?i32 = null,

    /// A setting indicating whether the firewall is protected against changes to
    /// the subnet associations.
    /// Use this setting to protect against
    /// accidentally modifying the subnet associations for a firewall that is in
    /// use. When you create a firewall, the operation initializes this setting to
    /// `TRUE`.
    subnet_change_protection: bool = false,

    /// The primary public subnets that Network Firewall is using for the firewall.
    /// Network Firewall creates a firewall endpoint in each subnet. Create a subnet
    /// mapping for each Availability Zone where you want to use the firewall.
    ///
    /// These subnets are all defined for a single, primary VPC, and each must
    /// belong to a different Availability Zone. Each of these subnets establishes
    /// the availability of the firewall in its Availability Zone.
    ///
    /// In addition to these subnets, you can define other endpoints for the
    /// firewall in `VpcEndpointAssociation` resources. You can define these
    /// additional endpoints for any VPC, and for any of the Availability Zones
    /// where the firewall resource already has a subnet mapping. VPC endpoint
    /// associations give you the ability to protect multiple VPCs using a single
    /// firewall, and to define multiple firewall endpoints for a VPC in a single
    /// Availability Zone.
    subnet_mappings: []const SubnetMapping,

    tags: ?[]const Tag = null,

    /// The unique identifier of the transit gateway associated with this firewall.
    /// This field is only present for transit gateway-attached firewalls.
    transit_gateway_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID that owns the transit gateway. This may
    /// be different from the firewall owner's account ID when using a shared
    /// transit gateway.
    transit_gateway_owner_account_id: ?[]const u8 = null,

    /// The unique identifier of the VPC where the firewall is in use.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .availability_zone_change_protection = "AvailabilityZoneChangeProtection",
        .availability_zone_mappings = "AvailabilityZoneMappings",
        .delete_protection = "DeleteProtection",
        .description = "Description",
        .enabled_analysis_types = "EnabledAnalysisTypes",
        .encryption_configuration = "EncryptionConfiguration",
        .firewall_arn = "FirewallArn",
        .firewall_id = "FirewallId",
        .firewall_name = "FirewallName",
        .firewall_policy_arn = "FirewallPolicyArn",
        .firewall_policy_change_protection = "FirewallPolicyChangeProtection",
        .number_of_associations = "NumberOfAssociations",
        .subnet_change_protection = "SubnetChangeProtection",
        .subnet_mappings = "SubnetMappings",
        .tags = "Tags",
        .transit_gateway_id = "TransitGatewayId",
        .transit_gateway_owner_account_id = "TransitGatewayOwnerAccountId",
        .vpc_id = "VpcId",
    };
};
