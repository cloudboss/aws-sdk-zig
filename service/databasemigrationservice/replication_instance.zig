const KerberosAuthenticationSettings = @import("kerberos_authentication_settings.zig").KerberosAuthenticationSettings;
const ReplicationPendingModifiedValues = @import("replication_pending_modified_values.zig").ReplicationPendingModifiedValues;
const ReplicationSubnetGroup = @import("replication_subnet_group.zig").ReplicationSubnetGroup;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Provides information that defines a replication instance.
pub const ReplicationInstance = struct {
    /// The amount of storage (in gigabytes) that is allocated for the replication
    /// instance.
    allocated_storage: i32 = 0,

    /// Boolean value indicating if minor version upgrades will be automatically
    /// applied to the
    /// instance.
    auto_minor_version_upgrade: bool = false,

    /// The Availability Zone for the instance.
    availability_zone: ?[]const u8 = null,

    /// The DNS name servers supported for the replication instance to access your
    /// on-premise
    /// source or target database.
    dns_name_servers: ?[]const u8 = null,

    /// The engine version number of the replication instance.
    ///
    /// If an engine version number is not specified when a replication instance is
    /// created, the
    /// default is the latest engine version available.
    ///
    /// When modifying a major engine version of an instance, also set
    /// `AllowMajorVersionUpgrade` to `true`.
    engine_version: ?[]const u8 = null,

    /// The expiration date of the free replication instance that is part of the
    /// Free DMS
    /// program.
    free_until: ?i64 = null,

    /// The time the replication instance was created.
    instance_create_time: ?i64 = null,

    /// Specifies the settings required for kerberos authentication when replicating
    /// an
    /// instance.
    kerberos_authentication_settings: ?KerberosAuthenticationSettings = null,

    /// An KMS key identifier that is used to encrypt the data on the replication
    /// instance.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether the replication instance is a Multi-AZ deployment. You
    /// can't set
    /// the `AvailabilityZone` parameter if the Multi-AZ parameter is set to
    /// `true`.
    multi_az: bool = false,

    /// The type of IP address protocol used by a replication instance, such as IPv4
    /// only or
    /// Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet
    /// supported.
    network_type: ?[]const u8 = null,

    /// The pending modification values.
    pending_modified_values: ?ReplicationPendingModifiedValues = null,

    /// The maintenance window times for the replication instance. Any pending
    /// upgrades to the
    /// replication instance are performed during this time.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Specifies the accessibility options for the replication instance. A value of
    /// `true` represents an instance with a public IP address. A value of
    /// `false` represents an instance with a private IP address. The default value
    /// is `true`.
    publicly_accessible: bool = false,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: ?[]const u8 = null,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class. It is a required parameter, although a default
    /// value is
    /// pre-selected in the DMS console.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [ Selecting the right DMS replication instance for
    /// your
    /// migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth).
    replication_instance_class: ?[]const u8 = null,

    /// The replication instance identifier is a required parameter. This parameter
    /// is stored as
    /// a lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must contain 1-63 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `myrepinstance`
    replication_instance_identifier: ?[]const u8 = null,

    /// One or more IPv6 addresses for the replication instance.
    replication_instance_ipv_6_addresses: ?[]const []const u8 = null,

    /// The private IP address of the replication instance.
    replication_instance_private_ip_address: ?[]const u8 = null,

    /// One or more private IP addresses for the replication instance.
    replication_instance_private_ip_addresses: ?[]const []const u8 = null,

    /// The public IP address of the replication instance.
    replication_instance_public_ip_address: ?[]const u8 = null,

    /// One or more public IP addresses for the replication instance.
    replication_instance_public_ip_addresses: ?[]const []const u8 = null,

    /// The status of the replication instance. The possible return values include:
    ///
    /// * `"available"`
    ///
    /// * `"creating"`
    ///
    /// * `"deleted"`
    ///
    /// * `"deleting"`
    ///
    /// * `"failed"`
    ///
    /// * `"modifying"`
    ///
    /// * `"upgrading"`
    ///
    /// * `"rebooting"`
    ///
    /// * `"resetting-master-credentials"`
    ///
    /// * `"storage-full"`
    ///
    /// * `"incompatible-credentials"`
    ///
    /// * `"incompatible-network"`
    ///
    /// * `"maintenance"`
    replication_instance_status: ?[]const u8 = null,

    /// The subnet group for the replication instance.
    replication_subnet_group: ?ReplicationSubnetGroup = null,

    /// The Availability Zone of the standby replication instance in a Multi-AZ
    /// deployment.
    secondary_availability_zone: ?[]const u8 = null,

    /// The VPC security group for the instance.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_zone = "AvailabilityZone",
        .dns_name_servers = "DnsNameServers",
        .engine_version = "EngineVersion",
        .free_until = "FreeUntil",
        .instance_create_time = "InstanceCreateTime",
        .kerberos_authentication_settings = "KerberosAuthenticationSettings",
        .kms_key_id = "KmsKeyId",
        .multi_az = "MultiAZ",
        .network_type = "NetworkType",
        .pending_modified_values = "PendingModifiedValues",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .publicly_accessible = "PubliclyAccessible",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_instance_class = "ReplicationInstanceClass",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .replication_instance_ipv_6_addresses = "ReplicationInstanceIpv6Addresses",
        .replication_instance_private_ip_address = "ReplicationInstancePrivateIpAddress",
        .replication_instance_private_ip_addresses = "ReplicationInstancePrivateIpAddresses",
        .replication_instance_public_ip_address = "ReplicationInstancePublicIpAddress",
        .replication_instance_public_ip_addresses = "ReplicationInstancePublicIpAddresses",
        .replication_instance_status = "ReplicationInstanceStatus",
        .replication_subnet_group = "ReplicationSubnetGroup",
        .secondary_availability_zone = "SecondaryAvailabilityZone",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};
