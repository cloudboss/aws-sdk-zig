const AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationAuthorizationConfigDetails = @import("aws_ecs_task_definition_volumes_efs_volume_configuration_authorization_config_details.zig").AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationAuthorizationConfigDetails;

/// Information about the Amazon Elastic File System file system that is used
/// for task storage.
pub const AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationDetails = struct {
    /// The authorization configuration details for the Amazon EFS file system.
    authorization_config: ?AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationAuthorizationConfigDetails,

    /// The Amazon EFS file system identifier to use.
    filesystem_id: ?[]const u8,

    /// The directory within the Amazon EFS file system to mount as the root
    /// directory inside the host.
    root_directory: ?[]const u8,

    /// Whether to enable encryption for Amazon EFS data in transit between the
    /// Amazon ECS host and the Amazon EFS server.
    transit_encryption: ?[]const u8,

    /// The port to use when sending encrypted data between the Amazon ECS host and
    /// the Amazon EFS server.
    transit_encryption_port: ?i32,

    pub const json_field_names = .{
        .authorization_config = "AuthorizationConfig",
        .filesystem_id = "FilesystemId",
        .root_directory = "RootDirectory",
        .transit_encryption = "TransitEncryption",
        .transit_encryption_port = "TransitEncryptionPort",
    };
};
