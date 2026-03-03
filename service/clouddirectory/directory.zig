const DirectoryState = @import("directory_state.zig").DirectoryState;

/// Directory structure that includes the directory name and directory ARN.
pub const Directory = struct {
    /// The date and time when the directory was created.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) that is associated with the directory. For
    /// more
    /// information, see arns.
    directory_arn: ?[]const u8 = null,

    /// The name of the directory.
    name: ?[]const u8 = null,

    /// The state of the directory. Can be either `Enabled`, `Disabled`, or
    /// `Deleted`.
    state: ?DirectoryState = null,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .directory_arn = "DirectoryArn",
        .name = "Name",
        .state = "State",
    };
};
