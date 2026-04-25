const EFSVolumeConfiguration = @import("efs_volume_configuration.zig").EFSVolumeConfiguration;
const Host = @import("host.zig").Host;
const S3FilesVolumeConfiguration = @import("s3_files_volume_configuration.zig").S3FilesVolumeConfiguration;

/// A data volume that's used in a job's container properties.
pub const Volume = struct {
    /// This parameter is specified when you're using an Amazon Elastic File System
    /// file system for job storage. Jobs
    /// that are running on Fargate resources must specify a `platformVersion` of at
    /// least
    /// `1.4.0`.
    efs_volume_configuration: ?EFSVolumeConfiguration = null,

    /// The contents of the `host` parameter determine whether your data volume
    /// persists
    /// on the host container instance and where it's stored. If the host parameter
    /// is empty, then the
    /// Docker daemon assigns a host path for your data volume. However, the data
    /// isn't guaranteed to
    /// persist after the containers that are associated with it stop running.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources and
    /// shouldn't be provided.
    host: ?Host = null,

    /// The name of the volume. It can be up to 255 characters long. It can contain
    /// uppercase and lowercase letters,
    /// numbers, hyphens (-), and underscores (_). This name is referenced in the
    /// `sourceVolume` parameter of container definition `mountPoints`.
    name: ?[]const u8 = null,

    /// This parameter is specified when you're using an S3Files file system for job
    /// storage.
    s_3_files_volume_configuration: ?S3FilesVolumeConfiguration = null,

    pub const json_field_names = .{
        .efs_volume_configuration = "efsVolumeConfiguration",
        .host = "host",
        .name = "name",
        .s_3_files_volume_configuration = "s3filesVolumeConfiguration",
    };
};
