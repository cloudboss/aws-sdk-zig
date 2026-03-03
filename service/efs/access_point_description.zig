const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const PosixUser = @import("posix_user.zig").PosixUser;
const RootDirectory = @import("root_directory.zig").RootDirectory;
const Tag = @import("tag.zig").Tag;

/// Provides a description of an EFS file system access point.
pub const AccessPointDescription = struct {
    /// The unique Amazon Resource Name (ARN) associated with the access
    /// point.
    access_point_arn: ?[]const u8 = null,

    /// The ID of the access point, assigned by Amazon EFS.
    access_point_id: ?[]const u8 = null,

    /// The opaque string specified in the request to ensure idempotent creation.
    client_token: ?[]const u8 = null,

    /// The ID of the EFS file system that the access point applies to.
    file_system_id: ?[]const u8 = null,

    /// Identifies the lifecycle phase of the access point.
    life_cycle_state: ?LifeCycleState = null,

    /// The name of the access point. This is the value of the `Name` tag.
    name: ?[]const u8 = null,

    /// Identifies the Amazon Web Services account that owns the access point
    /// resource.
    owner_id: ?[]const u8 = null,

    /// The full POSIX identity, including the user ID, group ID, and secondary
    /// group IDs on the access point that is used for all file operations by
    /// NFS clients using the access point.
    posix_user: ?PosixUser = null,

    /// The directory on the EFS file system that the access point exposes as the
    /// root
    /// directory to NFS clients using the access point.
    root_directory: ?RootDirectory = null,

    /// The tags associated with the access point, presented as an array of Tag
    /// objects.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .access_point_id = "AccessPointId",
        .client_token = "ClientToken",
        .file_system_id = "FileSystemId",
        .life_cycle_state = "LifeCycleState",
        .name = "Name",
        .owner_id = "OwnerId",
        .posix_user = "PosixUser",
        .root_directory = "RootDirectory",
        .tags = "Tags",
    };
};
