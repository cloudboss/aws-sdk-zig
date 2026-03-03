const AwsEcsTaskDefinitionVolumesDockerVolumeConfigurationDetails = @import("aws_ecs_task_definition_volumes_docker_volume_configuration_details.zig").AwsEcsTaskDefinitionVolumesDockerVolumeConfigurationDetails;
const AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationDetails = @import("aws_ecs_task_definition_volumes_efs_volume_configuration_details.zig").AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationDetails;
const AwsEcsTaskDefinitionVolumesHostDetails = @import("aws_ecs_task_definition_volumes_host_details.zig").AwsEcsTaskDefinitionVolumesHostDetails;

/// A data volume to mount from another container.
pub const AwsEcsTaskDefinitionVolumesDetails = struct {
    /// Information about a Docker volume.
    docker_volume_configuration: ?AwsEcsTaskDefinitionVolumesDockerVolumeConfigurationDetails = null,

    /// Information about the Amazon Elastic File System file system that is used
    /// for task storage.
    efs_volume_configuration: ?AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationDetails = null,

    /// Information about a bind mount host volume.
    host: ?AwsEcsTaskDefinitionVolumesHostDetails = null,

    /// The name of the data volume.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .docker_volume_configuration = "DockerVolumeConfiguration",
        .efs_volume_configuration = "EfsVolumeConfiguration",
        .host = "Host",
        .name = "Name",
    };
};
