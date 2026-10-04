const DataCollectionOptions = @import("data_collection_options.zig").DataCollectionOptions;
const GridImageType = @import("grid_image_type.zig").GridImageType;
const IamRole = @import("iam_role.zig").IamRole;
const ExadataIormConfig = @import("exadata_iorm_config.zig").ExadataIormConfig;
const LicenseModel = @import("license_model.zig").LicenseModel;
const ShapeAttribute = @import("shape_attribute.zig").ShapeAttribute;
const ExadbVmClusterStorageDetails = @import("exadb_vm_cluster_storage_details.zig").ExadbVmClusterStorageDetails;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about an Exascale VM cluster.
pub const ExadbVmCluster = struct {
    /// The name of the Grid Infrastructure (GI) cluster.
    cluster_name: ?[]const u8 = null,

    /// The date and time when the Exascale VM cluster was created.
    created_at: ?i64 = null,

    /// The set of diagnostic collection options enabled for the Exascale VM
    /// cluster.
    data_collection_options: ?DataCollectionOptions = null,

    /// The user-friendly name for the Exascale VM cluster.
    display_name: ?[]const u8 = null,

    /// The domain of the Exascale VM cluster.
    domain: ?[]const u8 = null,

    /// The number of elastic compute processing units (ECPUs) enabled on the
    /// Exascale VM cluster.
    enabled_ecpu_count: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the Exascale VM cluster.
    exadb_vm_cluster_arn: ?[]const u8 = null,

    /// The unique identifier of the Exascale VM cluster.
    exadb_vm_cluster_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Exascale storage vault associated with
    /// this Exascale VM cluster.
    exascale_db_storage_vault_arn: ?[]const u8 = null,

    /// The unique identifier of the Exascale storage vault associated with this
    /// Exascale VM cluster.
    exascale_db_storage_vault_id: ?[]const u8 = null,

    /// The software version of the Oracle Grid Infrastructure (GI) for the Exascale
    /// VM cluster.
    gi_version: ?[]const u8 = null,

    /// The Grid Infrastructure software image ID for the Exascale VM cluster.
    grid_image_id: ?[]const u8 = null,

    /// The type of Grid Infrastructure image for the Exascale VM cluster.
    grid_image_type: ?GridImageType = null,

    /// The host name for the Exascale VM cluster.
    hostname: ?[]const u8 = null,

    /// The Amazon Web Services Identity and Access Management (IAM) service roles
    /// associated with the Exascale VM cluster.
    iam_roles: ?[]const IamRole = null,

    /// The I/O Resource Management (IORM) configuration cache details for the
    /// Exascale VM cluster.
    iorm_config_cache: ?ExadataIormConfig = null,

    /// The Oracle Cloud ID (OCID) of the last maintenance update history entry.
    last_update_history_entry_id: ?[]const u8 = null,

    /// The Oracle license model applied to the Exascale VM cluster.
    license_model: ?LicenseModel = null,

    /// The port number configured for the listener on the Exascale VM cluster.
    listener_port: ?i32 = null,

    /// The amount of memory, in gigabytes (GB), that's allocated for the Exascale
    /// VM cluster.
    memory_size_in_g_bs: ?i32 = null,

    /// The number of nodes in the Exascale VM cluster.
    node_count: ?i32 = null,

    /// The OCID of the Exascale VM cluster.
    ocid: ?[]const u8 = null,

    /// The name of the OCI resource anchor for the Exascale VM cluster.
    oci_resource_anchor_name: ?[]const u8 = null,

    /// The HTTPS link to the Exascale VM cluster in Oracle Cloud Infrastructure
    /// (OCI).
    oci_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ODB network associated with this
    /// Exascale VM cluster.
    odb_network_arn: ?[]const u8 = null,

    /// The unique identifier of the ODB network for the Exascale VM cluster.
    odb_network_id: ?[]const u8 = null,

    /// The amount of progress made on the current operation on the Exascale VM
    /// cluster, expressed as a percentage.
    percent_progress: ?f32 = null,

    /// The fully qualified domain name (FQDN) of the DNS record for the Single
    /// Client Access Name (SCAN) IP addresses that are associated with the Exascale
    /// VM cluster.
    scan_dns_name: ?[]const u8 = null,

    /// The OCID of the DNS record for the SCAN IP addresses that are associated
    /// with the Exascale VM cluster.
    scan_dns_record_id: ?[]const u8 = null,

    /// The OCID of the SCAN IP addresses that are associated with the Exascale VM
    /// cluster.
    scan_ip_ids: ?[]const []const u8 = null,

    /// The port number for TCP connections to the Single Client Access Name (SCAN)
    /// listener for the Exascale VM cluster.
    scan_listener_port_tcp: ?i32 = null,

    /// The port number for TCP connections with SSL to the Single Client Access
    /// Name (SCAN) listener for the Exascale VM cluster.
    scan_listener_port_tcp_ssl: ?i32 = null,

    /// The hardware model name of the Exadata infrastructure that's running the
    /// Exascale VM cluster.
    shape: ?[]const u8 = null,

    /// The shape attribute for the Exascale VM cluster.
    shape_attribute: ?ShapeAttribute = null,

    /// The snapshot file system storage details for the Exascale VM cluster.
    snapshot_file_system_storage: ?ExadbVmClusterStorageDetails = null,

    /// The public key portion of one or more key pairs used for SSH access to the
    /// Exascale VM cluster.
    ssh_public_keys: ?[]const []const u8 = null,

    /// The current status of the Exascale VM cluster.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the Exascale VM cluster.
    status_reason: ?[]const u8 = null,

    /// The operating system version of the image chosen for the Exascale VM
    /// cluster.
    system_version: ?[]const u8 = null,

    /// The time zone of the Exascale VM cluster.
    time_zone: ?[]const u8 = null,

    /// The total number of ECPUs for the Exascale VM cluster.
    total_ecpu_count: ?i32 = null,

    /// The total file system storage details for the Exascale VM cluster.
    total_file_system_storage: ?ExadbVmClusterStorageDetails = null,

    /// The virtual IP (VIP) addresses associated with the Exascale VM cluster. One
    /// VIP address is assigned per node to support failover. If a node fails, its
    /// VIP is reassigned to another active node in the cluster.
    vip_ids: ?[]const []const u8 = null,

    /// The VM file system storage details for the Exascale VM cluster.
    vm_file_system_storage: ?ExadbVmClusterStorageDetails = null,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .created_at = "createdAt",
        .data_collection_options = "dataCollectionOptions",
        .display_name = "displayName",
        .domain = "domain",
        .enabled_ecpu_count = "enabledEcpuCount",
        .exadb_vm_cluster_arn = "exadbVmClusterArn",
        .exadb_vm_cluster_id = "exadbVmClusterId",
        .exascale_db_storage_vault_arn = "exascaleDbStorageVaultArn",
        .exascale_db_storage_vault_id = "exascaleDbStorageVaultId",
        .gi_version = "giVersion",
        .grid_image_id = "gridImageId",
        .grid_image_type = "gridImageType",
        .hostname = "hostname",
        .iam_roles = "iamRoles",
        .iorm_config_cache = "iormConfigCache",
        .last_update_history_entry_id = "lastUpdateHistoryEntryId",
        .license_model = "licenseModel",
        .listener_port = "listenerPort",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .node_count = "nodeCount",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .oci_url = "ociUrl",
        .odb_network_arn = "odbNetworkArn",
        .odb_network_id = "odbNetworkId",
        .percent_progress = "percentProgress",
        .scan_dns_name = "scanDnsName",
        .scan_dns_record_id = "scanDnsRecordId",
        .scan_ip_ids = "scanIpIds",
        .scan_listener_port_tcp = "scanListenerPortTcp",
        .scan_listener_port_tcp_ssl = "scanListenerPortTcpSsl",
        .shape = "shape",
        .shape_attribute = "shapeAttribute",
        .snapshot_file_system_storage = "snapshotFileSystemStorage",
        .ssh_public_keys = "sshPublicKeys",
        .status = "status",
        .status_reason = "statusReason",
        .system_version = "systemVersion",
        .time_zone = "timeZone",
        .total_ecpu_count = "totalEcpuCount",
        .total_file_system_storage = "totalFileSystemStorage",
        .vip_ids = "vipIds",
        .vm_file_system_storage = "vmFileSystemStorage",
    };
};
