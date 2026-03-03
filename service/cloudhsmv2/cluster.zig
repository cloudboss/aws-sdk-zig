const aws = @import("aws");

const BackupPolicy = @import("backup_policy.zig").BackupPolicy;
const BackupRetentionPolicy = @import("backup_retention_policy.zig").BackupRetentionPolicy;
const Certificates = @import("certificates.zig").Certificates;
const Hsm = @import("hsm.zig").Hsm;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const NetworkType = @import("network_type.zig").NetworkType;
const ClusterState = @import("cluster_state.zig").ClusterState;
const Tag = @import("tag.zig").Tag;

/// Contains information about an CloudHSM cluster.
pub const Cluster = struct {
    /// The cluster's backup policy.
    backup_policy: ?BackupPolicy = null,

    /// A policy that defines how the service retains backups.
    backup_retention_policy: ?BackupRetentionPolicy = null,

    /// Contains one or more certificates or a certificate signing request (CSR).
    certificates: ?Certificates = null,

    /// The cluster's identifier (ID).
    cluster_id: ?[]const u8 = null,

    /// The date and time when the cluster was created.
    create_timestamp: ?i64 = null,

    /// Contains information about the HSMs in the cluster.
    hsms: ?[]const Hsm = null,

    /// The type of HSM that the cluster contains.
    hsm_type: ?[]const u8 = null,

    /// The timestamp until when the cluster can be rolled back to its original HSM
    /// type.
    hsm_type_rollback_expiration: ?i64 = null,

    /// The mode of the cluster.
    mode: ?ClusterMode = null,

    /// The cluster's NetworkType can be IPv4 (the default) or DUALSTACK.
    /// The IPv4 NetworkType restricts communication between your application and
    /// the hardware security modules (HSMs) to the IPv4 protocol only. The
    /// DUALSTACK NetworkType enables communication over both IPv4 and IPv6
    /// protocols.
    /// To use DUALSTACK, configure your virtual private cloud (VPC) and subnets to
    /// support both IPv4 and IPv6.
    /// This configuration involves adding IPv6 Classless Inter-Domain Routing
    /// (CIDR) blocks to the existing IPv4 CIDR blocks in your subnets.
    /// The NetworkType you choose affects the network addressing options for your
    /// cluster. DUALSTACK provides more flexibility by supporting both IPv4 and
    /// IPv6 communication.
    network_type: ?NetworkType = null,

    /// The default password for the cluster's Pre-Crypto Officer (PRECO) user.
    pre_co_password: ?[]const u8 = null,

    /// The identifier (ID) of the cluster's security group.
    security_group: ?[]const u8 = null,

    /// The identifier (ID) of the backup used to create the cluster. This value
    /// exists only
    /// when the cluster was created from a backup.
    source_backup_id: ?[]const u8 = null,

    /// The cluster's state.
    state: ?ClusterState = null,

    /// A description of the cluster's state.
    state_message: ?[]const u8 = null,

    /// A map from availability zone to the cluster’s subnet in that availability
    /// zone.
    subnet_mapping: ?[]const aws.map.StringMapEntry = null,

    /// The list of tags for the cluster.
    tag_list: ?[]const Tag = null,

    /// The identifier (ID) of the virtual private cloud (VPC) that contains the
    /// cluster.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_policy = "BackupPolicy",
        .backup_retention_policy = "BackupRetentionPolicy",
        .certificates = "Certificates",
        .cluster_id = "ClusterId",
        .create_timestamp = "CreateTimestamp",
        .hsms = "Hsms",
        .hsm_type = "HsmType",
        .hsm_type_rollback_expiration = "HsmTypeRollbackExpiration",
        .mode = "Mode",
        .network_type = "NetworkType",
        .pre_co_password = "PreCoPassword",
        .security_group = "SecurityGroup",
        .source_backup_id = "SourceBackupId",
        .state = "State",
        .state_message = "StateMessage",
        .subnet_mapping = "SubnetMapping",
        .tag_list = "TagList",
        .vpc_id = "VpcId",
    };
};
