const aws = @import("aws");

const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const InternetProtocol = @import("internet_protocol.zig").InternetProtocol;

pub const ReplicationConfigurationTemplate = struct {
    /// Replication Configuration template ARN.
    arn: ?[]const u8 = null,

    /// Replication Configuration template associate default Application Migration
    /// Service Security group.
    associate_default_security_group: ?bool = null,

    /// Replication Configuration template bandwidth throttling.
    bandwidth_throttling: i64 = 0,

    /// Replication Configuration template create Public IP.
    create_public_ip: ?bool = null,

    /// Replication Configuration template data plane routing.
    data_plane_routing: ?ReplicationConfigurationDataPlaneRouting = null,

    /// Replication Configuration template use default large Staging Disk type.
    default_large_staging_disk_type: ?ReplicationConfigurationDefaultLargeStagingDiskType = null,

    /// Replication Configuration template EBS encryption.
    ebs_encryption: ?ReplicationConfigurationEbsEncryption = null,

    /// Replication Configuration template EBS encryption key ARN.
    ebs_encryption_key_arn: ?[]const u8 = null,

    /// Replication Configuration template internet protocol.
    internet_protocol: ?InternetProtocol = null,

    /// Replication Configuration template ID.
    replication_configuration_template_id: []const u8,

    /// Replication Configuration template server instance type.
    replication_server_instance_type: ?[]const u8 = null,

    /// Replication Configuration template server Security Groups IDs.
    replication_servers_security_groups_i_ds: ?[]const []const u8 = null,

    /// Replication Configuration template Staging Area subnet ID.
    staging_area_subnet_id: ?[]const u8 = null,

    /// Replication Configuration template Staging Area Tags.
    staging_area_tags: ?[]const aws.map.StringMapEntry = null,

    /// Replication Configuration template store snapshot on local zone.
    store_snapshot_on_local_zone: ?bool = null,

    /// Replication Configuration template Tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Replication Configuration template use Dedicated Replication Server.
    use_dedicated_replication_server: ?bool = null,

    /// Replication Configuration template use Fips Endpoint.
    use_fips_endpoint: ?bool = null,

    pub const json_field_names = .{
        .arn = "arn",
        .associate_default_security_group = "associateDefaultSecurityGroup",
        .bandwidth_throttling = "bandwidthThrottling",
        .create_public_ip = "createPublicIP",
        .data_plane_routing = "dataPlaneRouting",
        .default_large_staging_disk_type = "defaultLargeStagingDiskType",
        .ebs_encryption = "ebsEncryption",
        .ebs_encryption_key_arn = "ebsEncryptionKeyArn",
        .internet_protocol = "internetProtocol",
        .replication_configuration_template_id = "replicationConfigurationTemplateID",
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .store_snapshot_on_local_zone = "storeSnapshotOnLocalZone",
        .tags = "tags",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
        .use_fips_endpoint = "useFipsEndpoint",
    };
};
