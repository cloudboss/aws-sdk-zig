const AwsDmsReplicationInstanceReplicationSubnetGroupDetails = @import("aws_dms_replication_instance_replication_subnet_group_details.zig").AwsDmsReplicationInstanceReplicationSubnetGroupDetails;
const AwsDmsReplicationInstanceVpcSecurityGroupsDetails = @import("aws_dms_replication_instance_vpc_security_groups_details.zig").AwsDmsReplicationInstanceVpcSecurityGroupsDetails;

/// Provides details about an Database Migration Service (DMS) replication
/// instance. DMS uses a replication instance to connect to
/// your source data store, read the source data, and format the data for
/// consumption by the target data store.
pub const AwsDmsReplicationInstanceDetails = struct {
    /// The amount of storage (in gigabytes) that is allocated for the replication
    /// instance.
    allocated_storage: ?i32,

    /// Indicates whether minor engine upgrades are applied automatically to the
    /// replication instance during the maintenance
    /// window.
    auto_minor_version_upgrade: ?bool,

    /// The Availability Zone that the replication instance is created in. The
    /// default value is a random, system-chosen
    /// Availability Zone in the endpoint's Amazon Web Services Region, such as
    /// `us-east-1d`.
    availability_zone: ?[]const u8,

    /// The engine version number of the replication instance. If an engine version
    /// number is not specified when a
    /// replication instance is created, the default is the latest engine version
    /// available.
    engine_version: ?[]const u8,

    /// An KMS key identifier that is used to encrypt the data on the replication
    /// instance. If you don't
    /// specify a value for the `KmsKeyId` parameter, DMS uses your default
    /// encryption key.
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your
    /// Amazon Web Services account has a different default encryption key for each
    /// Amazon Web Services Region.
    kms_key_id: ?[]const u8,

    /// Specifies whether the replication instance is deployed across multiple
    /// Availability Zones (AZs). You can't set the
    /// `AvailabilityZone` parameter if the `MultiAZ` parameter is set to `true`.
    multi_az: ?bool,

    /// The maintenance window times for the replication instance. Upgrades to the
    /// replication instance are performed during
    /// this time.
    preferred_maintenance_window: ?[]const u8,

    /// Specifies the accessibility options for the replication instance. A value of
    /// `true` represents an instance
    /// with a public IP address. A value of `false` represents an instance with a
    /// private IP address. The default
    /// value is `true`.
    publicly_accessible: ?bool,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified replication instance class.
    replication_instance_class: ?[]const u8,

    /// The replication instance identifier.
    replication_instance_identifier: ?[]const u8,

    /// The subnet group for the replication instance.
    replication_subnet_group: ?AwsDmsReplicationInstanceReplicationSubnetGroupDetails,

    /// The virtual private cloud (VPC) security group for the replication instance.
    vpc_security_groups: ?[]const AwsDmsReplicationInstanceVpcSecurityGroupsDetails,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_zone = "AvailabilityZone",
        .engine_version = "EngineVersion",
        .kms_key_id = "KmsKeyId",
        .multi_az = "MultiAZ",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .publicly_accessible = "PubliclyAccessible",
        .replication_instance_class = "ReplicationInstanceClass",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .replication_subnet_group = "ReplicationSubnetGroup",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};
