/// Contains summary information about a workspace.
pub const WorkspaceSummary = struct {
    /// The Amazon Resource Name (ARN) of the workspace.
    arn: ?[]const u8 = null,

    /// The unique identifier of the workspace.
    id: ?[]const u8 = null,

    /// The Amazon Web Services Region where the workspace was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the workspace was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the workspace.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};
