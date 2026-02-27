const ComputeModel = @import("compute_model.zig").ComputeModel;
const DataCollectionOptions = @import("data_collection_options.zig").DataCollectionOptions;
const DiskRedundancy = @import("disk_redundancy.zig").DiskRedundancy;
const IamRole = @import("iam_role.zig").IamRole;
const ExadataIormConfig = @import("exadata_iorm_config.zig").ExadataIormConfig;
const LicenseModel = @import("license_model.zig").LicenseModel;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about a VM cluster.
pub const CloudVmClusterSummary = struct {
    /// The Amazon Resource Name (ARN) of the Exadata infrastructure that this VM
    /// cluster belongs to.
    cloud_exadata_infrastructure_arn: ?[]const u8,

    /// The unique identifier of the Exadata infrastructure that this VM cluster
    /// belongs to.
    cloud_exadata_infrastructure_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the VM cluster.
    cloud_vm_cluster_arn: ?[]const u8,

    /// The unique identifier of the VM cluster.
    cloud_vm_cluster_id: []const u8,

    /// The name of the Grid Infrastructure (GI) cluster.
    cluster_name: ?[]const u8,

    /// The OCI model compute model used when you create or clone an instance: ECPU
    /// or OCPU. An ECPU is an abstracted measure of compute resources. ECPUs are
    /// based on the number of cores elastically allocated from a pool of compute
    /// and storage servers. An OCPU is a legacy physical measure of compute
    /// resources. OCPUs are based on the physical core of a processor with
    /// hyper-threading enabled.
    compute_model: ?ComputeModel,

    /// The number of CPU cores enabled on the VM cluster.
    cpu_core_count: ?i32,

    /// The date and time when the VM cluster was created.
    created_at: ?i64,

    data_collection_options: ?DataCollectionOptions,

    /// The size of the data disk group, in terabytes (TB), that's allocated for the
    /// VM cluster.
    data_storage_size_in_t_bs: ?f64,

    /// The amount of local node storage, in gigabytes (GB), that's allocated for
    /// the VM cluster.
    db_node_storage_size_in_g_bs: ?i32,

    /// The list of database servers for the VM cluster.
    db_servers: ?[]const []const u8,

    /// The type of redundancy configured for the VM cluster. `NORMAL` is 2-way
    /// redundancy. `HIGH` is 3-way redundancy.
    disk_redundancy: ?DiskRedundancy,

    /// The user-friendly name for the VM cluster.
    display_name: ?[]const u8,

    /// The domain of the VM cluster.
    domain: ?[]const u8,

    /// The software version of the Oracle Grid Infrastructure (GI) for the VM
    /// cluster.
    gi_version: ?[]const u8,

    /// The host name for the VM cluster.
    hostname: ?[]const u8,

    /// The Amazon Web Services Identity and Access Management (IAM) service roles
    /// associated with the VM cluster in the summary information.
    iam_roles: ?[]const IamRole,

    iorm_config_cache: ?ExadataIormConfig,

    /// Indicates whether database backups to local Exadata storage is enabled for
    /// the VM cluster.
    is_local_backup_enabled: ?bool,

    /// Indicates whether the VM cluster is configured with a sparse disk group.
    is_sparse_diskgroup_enabled: ?bool,

    /// The Oracle Cloud ID (OCID) of the last maintenance update history entry.
    last_update_history_entry_id: ?[]const u8,

    /// The Oracle license model applied to the VM cluster.
    license_model: ?LicenseModel,

    /// The port number configured for the listener on the VM cluster.
    listener_port: ?i32,

    /// The amount of memory, in gigabytes (GB), that's allocated for the VM
    /// cluster.
    memory_size_in_g_bs: ?i32,

    /// The number of nodes in the VM cluster.
    node_count: ?i32,

    /// The OCID of the VM cluster.
    ocid: ?[]const u8,

    /// The name of the OCI resource anchor for the VM cluster.
    oci_resource_anchor_name: ?[]const u8,

    /// The HTTPS link to the VM cluster in OCI.
    oci_url: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the ODB network associated with this VM
    /// cluster.
    odb_network_arn: ?[]const u8,

    /// The unique identifier of the ODB network for the VM cluster.
    odb_network_id: ?[]const u8,

    /// The amount of progress made on the current operation on the VM cluster,
    /// expressed as a percentage.
    percent_progress: ?f32,

    /// The FQDN of the DNS record for the Single Client Access Name (SCAN) IP
    /// addresses that are associated with the VM cluster.
    scan_dns_name: ?[]const u8,

    /// The OCID of the DNS record for the SCAN IP addresses that are associated
    /// with the VM cluster.
    scan_dns_record_id: ?[]const u8,

    /// The OCID of the SCAN IP addresses that are associated with the VM cluster.
    scan_ip_ids: ?[]const []const u8,

    /// The hardware model name of the Exadata infrastructure that's running the VM
    /// cluster.
    shape: ?[]const u8,

    /// The public key portion of one or more key pairs used for SSH access to the
    /// VM cluster.
    ssh_public_keys: ?[]const []const u8,

    /// The current status of the VM cluster.
    status: ?ResourceStatus,

    /// Additional information about the status of the VM cluster.
    status_reason: ?[]const u8,

    /// The amount of local node storage, in gigabytes (GB), that's allocated to the
    /// VM cluster.
    storage_size_in_g_bs: ?i32,

    /// The operating system version of the image chosen for the VM cluster.
    system_version: ?[]const u8,

    /// The time zone of the VM cluster.
    time_zone: ?[]const u8,

    /// The virtual IP (VIP) addresses that are associated with the VM cluster.
    /// Oracle's Cluster Ready Services (CRS) creates and maintains one VIP address
    /// for each node in the VM cluster to enable failover. If one node fails, the
    /// VIP is reassigned to another active node in the cluster.
    vip_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .cloud_exadata_infrastructure_arn = "cloudExadataInfrastructureArn",
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .cloud_vm_cluster_arn = "cloudVmClusterArn",
        .cloud_vm_cluster_id = "cloudVmClusterId",
        .cluster_name = "clusterName",
        .compute_model = "computeModel",
        .cpu_core_count = "cpuCoreCount",
        .created_at = "createdAt",
        .data_collection_options = "dataCollectionOptions",
        .data_storage_size_in_t_bs = "dataStorageSizeInTBs",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_servers = "dbServers",
        .disk_redundancy = "diskRedundancy",
        .display_name = "displayName",
        .domain = "domain",
        .gi_version = "giVersion",
        .hostname = "hostname",
        .iam_roles = "iamRoles",
        .iorm_config_cache = "iormConfigCache",
        .is_local_backup_enabled = "isLocalBackupEnabled",
        .is_sparse_diskgroup_enabled = "isSparseDiskgroupEnabled",
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
        .shape = "shape",
        .ssh_public_keys = "sshPublicKeys",
        .status = "status",
        .status_reason = "statusReason",
        .storage_size_in_g_bs = "storageSizeInGBs",
        .system_version = "systemVersion",
        .time_zone = "timeZone",
        .vip_ids = "vipIds",
    };
};
