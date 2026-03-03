/// Configuration parameters for provisioning an DMS Serverless replication.
pub const ComputeConfig = struct {
    /// The Availability Zone where the DMS Serverless replication using this
    /// configuration
    /// will run. The default value is a random, system-chosen Availability Zone in
    /// the
    /// configuration's Amazon Web Services Region, for example, `"us-west-2"`. You
    /// can't set this
    /// parameter if the `MultiAZ` parameter is set to `true`.
    availability_zone: ?[]const u8 = null,

    /// A list of custom DNS name servers supported for the DMS Serverless
    /// replication to
    /// access your source or target database. This list overrides the default name
    /// servers
    /// supported by the DMS Serverless replication. You can specify a
    /// comma-separated list of
    /// internet addresses for up to four DNS name servers. For example:
    /// `"1.1.1.1,2.2.2.2,3.3.3.3,4.4.4.4"`
    dns_name_servers: ?[]const u8 = null,

    /// An Key Management Service (KMS) key Amazon Resource Name (ARN) that is used
    /// to encrypt the data
    /// during DMS Serverless replication.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, DMS uses your
    /// default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account
    /// has a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the maximum value of the DMS capacity units (DCUs) for which a
    /// given DMS
    /// Serverless replication can be provisioned. A single DCU is 2GB of RAM, with
    /// 1 DCU as the
    /// minimum value allowed. The list of valid DCU values includes 1, 2, 4, 8, 16,
    /// 32, 64, 128,
    /// 192, 256, and 384. So, the maximum value that you can specify for DMS
    /// Serverless is 384.
    /// The `MaxCapacityUnits` parameter is the only DCU parameter you are required
    /// to
    /// specify.
    max_capacity_units: ?i32 = null,

    /// Specifies the minimum value of the DMS capacity units (DCUs) for which a
    /// given DMS
    /// Serverless replication can be provisioned. A single DCU is 2GB of RAM, with
    /// 1 DCU as the
    /// minimum value allowed. The list of valid DCU values includes 1, 2, 4, 8, 16,
    /// 32, 64, 128,
    /// 192, 256, and 384. So, the minimum DCU value that you can specify for DMS
    /// Serverless is
    /// 1. If you don't set this value, DMS sets this parameter to the minimum DCU
    /// value allowed,
    /// 1. If there is no current source activity, DMS scales down your replication
    /// until it
    /// reaches the value specified in `MinCapacityUnits`.
    min_capacity_units: ?i32 = null,

    /// Specifies whether the DMS Serverless replication is a Multi-AZ deployment.
    /// You can't
    /// set the `AvailabilityZone` parameter if the `MultiAZ` parameter is
    /// set to `true`.
    multi_az: ?bool = null,

    /// The weekly time range during which system maintenance can occur for the DMS
    /// Serverless
    /// replication, in Universal Coordinated Time (UTC). The format is
    /// `ddd:hh24:mi-ddd:hh24:mi`.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time per
    /// Amazon Web Services Region. This maintenance occurs on a random day of the
    /// week. Valid values for days of
    /// the week include `Mon`, `Tue`, `Wed`, `Thu`,
    /// `Fri`, `Sat`, and `Sun`.
    ///
    /// Constraints include a minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Specifies a subnet group identifier to associate with the DMS Serverless
    /// replication.
    replication_subnet_group_id: ?[]const u8 = null,

    /// Specifies the virtual private cloud (VPC) security group to use with the DMS
    /// Serverless replication. The VPC security group must work with the VPC
    /// containing the
    /// replication.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .dns_name_servers = "DnsNameServers",
        .kms_key_id = "KmsKeyId",
        .max_capacity_units = "MaxCapacityUnits",
        .min_capacity_units = "MinCapacityUnits",
        .multi_az = "MultiAZ",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .replication_subnet_group_id = "ReplicationSubnetGroupId",
        .vpc_security_group_ids = "VpcSecurityGroupIds",
    };
};
