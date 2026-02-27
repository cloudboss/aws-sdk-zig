const aws = @import("aws");

const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const PITPolicyRule = @import("pit_policy_rule.zig").PITPolicyRule;

pub const ReplicationConfigurationTemplate = struct {
    /// The Replication Configuration Template ARN.
    arn: ?[]const u8,

    /// Whether to associate the default Elastic Disaster Recovery Security group
    /// with the Replication Configuration Template.
    associate_default_security_group: ?bool,

    /// Whether to allow the AWS replication agent to automatically replicate newly
    /// added disks.
    auto_replicate_new_disks: ?bool,

    /// Configure bandwidth throttling for the outbound data transfer rate of the
    /// Source Server in Mbps.
    bandwidth_throttling: i64 = 0,

    /// Whether to create a Public IP for the Recovery Instance by default.
    create_public_ip: ?bool,

    /// The data plane routing mechanism that will be used for replication.
    data_plane_routing: ?ReplicationConfigurationDataPlaneRouting,

    /// The Staging Disk EBS volume type to be used during replication.
    default_large_staging_disk_type: ?ReplicationConfigurationDefaultLargeStagingDiskType,

    /// The type of EBS encryption to be used during replication.
    ebs_encryption: ?ReplicationConfigurationEbsEncryption,

    /// The ARN of the EBS encryption key to be used during replication.
    ebs_encryption_key_arn: ?[]const u8,

    /// The Point in time (PIT) policy to manage snapshots taken during replication.
    pit_policy: ?[]const PITPolicyRule,

    /// The Replication Configuration Template ID.
    replication_configuration_template_id: []const u8,

    /// The instance type to be used for the replication server.
    replication_server_instance_type: ?[]const u8,

    /// The security group IDs that will be used by the replication server.
    replication_servers_security_groups_i_ds: ?[]const []const u8,

    /// The subnet to be used by the replication staging area.
    staging_area_subnet_id: ?[]const u8,

    /// A set of tags to be associated with all resources created in the replication
    /// staging area: EC2 replication server, EBS volumes, EBS snapshots, etc.
    staging_area_tags: ?[]const aws.map.StringMapEntry,

    /// A set of tags to be associated with the Replication Configuration Template
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// Whether to use a dedicated Replication Server in the replication staging
    /// area.
    use_dedicated_replication_server: ?bool,

    pub const json_field_names = .{
        .arn = "arn",
        .associate_default_security_group = "associateDefaultSecurityGroup",
        .auto_replicate_new_disks = "autoReplicateNewDisks",
        .bandwidth_throttling = "bandwidthThrottling",
        .create_public_ip = "createPublicIP",
        .data_plane_routing = "dataPlaneRouting",
        .default_large_staging_disk_type = "defaultLargeStagingDiskType",
        .ebs_encryption = "ebsEncryption",
        .ebs_encryption_key_arn = "ebsEncryptionKeyArn",
        .pit_policy = "pitPolicy",
        .replication_configuration_template_id = "replicationConfigurationTemplateID",
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .tags = "tags",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
    };
};
