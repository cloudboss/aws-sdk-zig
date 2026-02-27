const OntapDeploymentType = @import("ontap_deployment_type.zig").OntapDeploymentType;
const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;

/// The ONTAP configuration properties of the FSx for ONTAP file system that you
/// are creating.
pub const CreateFileSystemOntapConfiguration = struct {
    automatic_backup_retention_days: ?i32,

    daily_automatic_backup_start_time: ?[]const u8,

    /// Specifies the FSx for ONTAP file system deployment type to use in creating
    /// the file system.
    ///
    /// * `MULTI_AZ_1` - A high availability file system configured
    /// for Multi-AZ redundancy to tolerate temporary Availability Zone (AZ)
    /// unavailability. This is a first-generation FSx for ONTAP file system.
    ///
    /// * `MULTI_AZ_2` - A high availability file system configured for Multi-AZ
    ///   redundancy to tolerate
    /// temporary AZ unavailability. This is a second-generation FSx for ONTAP file
    /// system.
    ///
    /// * `SINGLE_AZ_1` - A file system configured for Single-AZ
    /// redundancy. This is a first-generation FSx for ONTAP file system.
    ///
    /// * `SINGLE_AZ_2` - A file system configured with multiple high-availability
    ///   (HA) pairs for Single-AZ redundancy.
    /// This is a second-generation FSx for ONTAP file system.
    ///
    /// For information about the use cases for Multi-AZ and Single-AZ deployments,
    /// refer to
    /// [Choosing a file system deployment
    /// type](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/high-availability-AZ.html).
    deployment_type: OntapDeploymentType,

    /// The SSD IOPS configuration for the FSx for ONTAP file system.
    disk_iops_configuration: ?DiskIopsConfiguration,

    /// (Multi-AZ only) Specifies the IPv4 address range in which the endpoints to
    /// access your
    /// file system will be created. By default in the Amazon FSx API, Amazon FSx
    /// selects an unused IP address range for you from the 198.19.* range. By
    /// default in the
    /// Amazon FSx console, Amazon FSx chooses the last 64 IP addresses from
    /// the VPC’s primary CIDR range to use as the endpoint IP address range for the
    /// file system.
    /// You can have overlapping endpoint IP addresses for file systems deployed in
    /// the
    /// same VPC/route tables, as long as they don't overlap with any subnet.
    endpoint_ip_address_range: ?[]const u8,

    /// (Multi-AZ only) Specifies the IPv6 address range in which the endpoints to
    /// access
    /// your file system will be created. By default in the Amazon FSx API and
    /// Amazon FSx console, Amazon FSx selects an available /118 IP address
    /// range for you from one of the VPC's CIDR ranges. You can have overlapping
    /// endpoint
    /// IP addresses for file systems deployed in the same VPC/route tables, as long
    /// as they
    /// don't overlap with any subnet.
    endpoint_ipv_6_address_range: ?[]const u8,

    /// The ONTAP administrative password for the `fsxadmin` user with which you
    /// administer your file system using the NetApp ONTAP CLI and REST API.
    fsx_admin_password: ?[]const u8,

    /// Specifies how many high-availability (HA) pairs of file servers will power
    /// your file system. First-generation file systems are powered by 1 HA pair.
    /// Second-generation multi-AZ file systems are powered by 1 HA pair. Second
    /// generation single-AZ file systems are powered by up to 12 HA pairs. The
    /// default value is 1.
    /// The value of this property affects the values of `StorageCapacity`,
    /// `Iops`, and `ThroughputCapacity`. For more information, see
    /// [High-availability (HA)
    /// pairs](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/administering-file-systems.html#HA-pairs) in the FSx for ONTAP user guide. Block storage protocol support
    /// (iSCSI and NVMe over TCP) is disabled on file systems with more than 6 HA
    /// pairs. For more information, see
    /// [Using block storage
    /// protocols](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/supported-fsx-clients.html#using-block-storage).
    ///
    /// Amazon FSx responds with an HTTP status code 400 (Bad Request) for the
    /// following conditions:
    ///
    /// * The value of `HAPairs` is less than 1 or greater than 12.
    ///
    /// * The value of `HAPairs` is greater than 1 and the value of `DeploymentType`
    ///   is `SINGLE_AZ_1`, `MULTI_AZ_1`, or `MULTI_AZ_2`.
    ha_pairs: ?i32,

    /// Required when `DeploymentType` is set to `MULTI_AZ_1` or `MULTI_AZ_2`. This
    /// specifies the subnet in which you want the preferred file server to be
    /// located.
    preferred_subnet_id: ?[]const u8,

    /// (Multi-AZ only) Specifies the route tables in which Amazon FSx creates the
    /// rules
    /// for routing traffic to the correct file server. You should specify all
    /// virtual private cloud
    /// (VPC) route tables associated with the subnets in which your clients are
    /// located. By default,
    /// Amazon FSx selects your VPC's default route table.
    ///
    /// Amazon FSx manages these route tables for Multi-AZ file systems using
    /// tag-based authentication.
    /// These route tables are tagged with `Key: AmazonFSx; Value:
    /// ManagedByAmazonFSx`.
    /// When creating FSx for ONTAP Multi-AZ file systems using CloudFormation we
    /// recommend that you add the
    /// `Key: AmazonFSx; Value: ManagedByAmazonFSx` tag manually.
    route_table_ids: ?[]const []const u8,

    /// Sets the throughput capacity for the file system that you're creating in
    /// megabytes per second (MBps). For more information, see
    /// [Managing throughput
    /// capacity](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-throughput-capacity.html)
    /// in the FSx for ONTAP User Guide.
    ///
    /// Amazon FSx responds with an HTTP status code 400 (Bad Request) for the
    /// following conditions:
    ///
    /// * The value of `ThroughputCapacity` and `ThroughputCapacityPerHAPair` are
    ///   not the same value.
    ///
    /// * The value of `ThroughputCapacity` when divided by the value of `HAPairs`
    ///   is outside of the valid range for `ThroughputCapacity`.
    throughput_capacity: ?i32,

    /// Use to choose the throughput capacity per HA pair, rather than the total
    /// throughput for the file system.
    ///
    /// You can define either the `ThroughputCapacityPerHAPair` or the
    /// `ThroughputCapacity` when creating a file system, but not both.
    ///
    /// This field and `ThroughputCapacity` are the same for file systems powered by
    /// one HA pair.
    ///
    /// * For `SINGLE_AZ_1` and `MULTI_AZ_1` file systems, valid values are 128,
    ///   256, 512, 1024, 2048, or 4096 MBps.
    ///
    /// * For `SINGLE_AZ_2`, valid values are 1536, 3072, or 6144 MBps.
    ///
    /// * For `MULTI_AZ_2`, valid values are 384, 768, 1536, 3072, or 6144 MBps.
    ///
    /// Amazon FSx responds with an HTTP status code 400 (Bad Request) for the
    /// following conditions:
    ///
    /// * The value of `ThroughputCapacity` and `ThroughputCapacityPerHAPair` are
    ///   not the same value for file systems with one HA pair.
    ///
    /// * The value of deployment type is `SINGLE_AZ_2` and `ThroughputCapacity` /
    ///   `ThroughputCapacityPerHAPair` is not a valid HA pair (a value between 1
    ///   and 12).
    ///
    /// * The value of `ThroughputCapacityPerHAPair` is not a valid value.
    throughput_capacity_per_ha_pair: ?i32,

    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .deployment_type = "DeploymentType",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .endpoint_ip_address_range = "EndpointIpAddressRange",
        .endpoint_ipv_6_address_range = "EndpointIpv6AddressRange",
        .fsx_admin_password = "FsxAdminPassword",
        .ha_pairs = "HAPairs",
        .preferred_subnet_id = "PreferredSubnetId",
        .route_table_ids = "RouteTableIds",
        .throughput_capacity = "ThroughputCapacity",
        .throughput_capacity_per_ha_pair = "ThroughputCapacityPerHAPair",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
