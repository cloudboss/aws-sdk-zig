const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;

/// The configuration updates for an Amazon FSx for NetApp ONTAP file system.
pub const UpdateFileSystemOntapConfiguration = struct {
    /// (Multi-AZ only) A list of IDs of new virtual private cloud (VPC) route
    /// tables
    /// to associate (add) with your Amazon FSx for NetApp ONTAP file system.
    add_route_table_ids: ?[]const []const u8,

    automatic_backup_retention_days: ?i32,

    daily_automatic_backup_start_time: ?[]const u8,

    /// The SSD IOPS (input output operations per second) configuration for an
    /// Amazon FSx for NetApp ONTAP file system. The default is 3 IOPS per GB of
    /// storage capacity,
    /// but you can provision additional IOPS per GB of storage. The configuration
    /// consists
    /// of an IOPS mode (`AUTOMATIC` or `USER_PROVISIONED`), and in
    /// the case of `USER_PROVISIONED` IOPS, the total number of SSD IOPS
    /// provisioned.
    /// For more information, see
    /// [File system storage capacity and
    /// IOPS](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/storage-capacity-and-IOPS.html).
    disk_iops_configuration: ?DiskIopsConfiguration,

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

    /// Update the password for the `fsxadmin` user by entering a new password.
    /// You use the `fsxadmin` user to access the NetApp ONTAP CLI and REST API to
    /// manage your file system resources.
    /// For more information, see
    /// [Managing resources using NetApp
    /// Application](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-resources-ontap-apps.html).
    fsx_admin_password: ?[]const u8,

    /// Use to update the number of high-availability (HA) pairs for a
    /// second-generation single-AZ file system.
    /// If you increase the number of HA pairs for your file system, you must
    /// specify proportional increases for `StorageCapacity`,
    /// `Iops`, and `ThroughputCapacity`. For more information, see
    /// [High-availability (HA)
    /// pairs](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/administering-file-systems.html#HA-pairs) in the FSx for ONTAP user guide. Block storage protocol support
    /// (iSCSI and NVMe over TCP) is disabled on file systems with more than 6 HA
    /// pairs. For more information, see
    /// [Using block storage
    /// protocols](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/supported-fsx-clients.html#using-block-storage).
    ha_pairs: ?i32,

    /// (Multi-AZ only) A list of IDs of existing virtual private cloud (VPC)
    /// route tables to disassociate (remove) from your Amazon FSx for NetApp ONTAP
    /// file system. You can use
    /// the API operation to retrieve the
    /// list of VPC route table IDs for a file system.
    remove_route_table_ids: ?[]const []const u8,

    /// Enter a new value to change the amount of throughput capacity for the file
    /// system in megabytes per second (MBps). For more information, see
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
    /// This field and `ThroughputCapacity` cannot be defined in the same API call,
    /// but one is required.
    ///
    /// This field and `ThroughputCapacity` are the same for file systems with one
    /// HA pair.
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
        .add_route_table_ids = "AddRouteTableIds",
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .endpoint_ipv_6_address_range = "EndpointIpv6AddressRange",
        .fsx_admin_password = "FsxAdminPassword",
        .ha_pairs = "HAPairs",
        .remove_route_table_ids = "RemoveRouteTableIds",
        .throughput_capacity = "ThroughputCapacity",
        .throughput_capacity_per_ha_pair = "ThroughputCapacityPerHAPair",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
