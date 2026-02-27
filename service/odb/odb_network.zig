const ManagedServices = @import("managed_services.zig").ManagedServices;
const OciDnsForwardingConfig = @import("oci_dns_forwarding_config.zig").OciDnsForwardingConfig;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about an ODB network.
pub const OdbNetwork = struct {
    /// The Amazon Web Services Availability Zone (AZ) where the ODB network is
    /// located.
    availability_zone: ?[]const u8,

    /// The AZ ID of the AZ where the ODB network is located.
    availability_zone_id: ?[]const u8,

    /// The CIDR range of the backup subnet in the ODB network.
    backup_subnet_cidr: ?[]const u8,

    /// The CIDR range of the client subnet in the ODB network.
    client_subnet_cidr: ?[]const u8,

    /// The date and time when the ODB network was created.
    created_at: ?i64,

    /// The domain name for the resources in the ODB network.
    custom_domain_name: ?[]const u8,

    /// The DNS prefix to the default DNS domain name. The default DNS domain name
    /// is oraclevcn.com.
    default_dns_prefix: ?[]const u8,

    /// The user-friendly name of the ODB network.
    display_name: ?[]const u8,

    /// The managed services configuration for the ODB network.
    managed_services: ?ManagedServices,

    /// The DNS resolver endpoint in OCI for forwarding DNS queries for the
    /// ociPrivateZone domain.
    oci_dns_forwarding_configs: ?[]const OciDnsForwardingConfig,

    /// The unique identifier of the OCI network anchor for the ODB network.
    oci_network_anchor_id: ?[]const u8,

    /// The URL of the OCI network anchor for the ODB network.
    oci_network_anchor_url: ?[]const u8,

    /// The name of the OCI resource anchor that's associated with the ODB network.
    oci_resource_anchor_name: ?[]const u8,

    /// The Oracle Cloud ID (OCID) for the Virtual Cloud Network (VCN) that's
    /// associated with the ODB network.
    oci_vcn_id: ?[]const u8,

    /// The URL for the VCN that's associated with the ODB network.
    oci_vcn_url: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the ODB network.
    odb_network_arn: ?[]const u8,

    /// The unique identifier of the ODB network.
    odb_network_id: []const u8,

    /// The list of CIDR ranges from the peered VPC that are allowed access to the
    /// ODB network.
    peered_cidrs: ?[]const []const u8,

    /// The amount of progress made on the current operation on the ODB network,
    /// expressed as a percentage.
    percent_progress: ?f32,

    /// The current status of the ODB network.
    status: ?ResourceStatus,

    /// Additional information about the current status of the ODB network.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .backup_subnet_cidr = "backupSubnetCidr",
        .client_subnet_cidr = "clientSubnetCidr",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .default_dns_prefix = "defaultDnsPrefix",
        .display_name = "displayName",
        .managed_services = "managedServices",
        .oci_dns_forwarding_configs = "ociDnsForwardingConfigs",
        .oci_network_anchor_id = "ociNetworkAnchorId",
        .oci_network_anchor_url = "ociNetworkAnchorUrl",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .oci_vcn_id = "ociVcnId",
        .oci_vcn_url = "ociVcnUrl",
        .odb_network_arn = "odbNetworkArn",
        .odb_network_id = "odbNetworkId",
        .peered_cidrs = "peeredCidrs",
        .percent_progress = "percentProgress",
        .status = "status",
        .status_reason = "statusReason",
    };
};
