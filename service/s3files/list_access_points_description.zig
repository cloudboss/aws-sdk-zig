const PosixUser = @import("posix_user.zig").PosixUser;
const RootDirectory = @import("root_directory.zig").RootDirectory;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

/// Contains information about an S3 File System Access Point returned in list
/// operations.
pub const ListAccessPointsDescription = struct {
    /// The Amazon Resource Name (ARN) of the access point.
    access_point_arn: []const u8,

    /// The ID of the access point.
    access_point_id: []const u8,

    /// The ID of the S3 File System.
    file_system_id: []const u8,

    /// The name of the access point.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the access point owner.
    owner_id: []const u8,

    /// The POSIX identity configured for this access point.
    posix_user: ?PosixUser = null,

    /// The root directory configuration for this access point.
    root_directory: ?RootDirectory = null,

    /// The current status of the access point.
    status: LifeCycleState,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .access_point_id = "accessPointId",
        .file_system_id = "fileSystemId",
        .name = "name",
        .owner_id = "ownerId",
        .posix_user = "posixUser",
        .root_directory = "rootDirectory",
        .status = "status",
    };
};
