const ViewType = @import("view_type.zig").ViewType;

/// A summary of a view version's metadata.
pub const ViewVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the view version.
    arn: ?[]const u8 = null,

    /// The description of the view version.
    description: ?[]const u8 = null,

    /// The identifier of the view version.
    id: ?[]const u8 = null,

    /// The name of the view version.
    name: ?[]const u8 = null,

    /// The type of the view version.
    @"type": ?ViewType = null,

    /// The sequentially incremented version of the view version.
    version: i32 = 0,

    /// The description of the view version.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .@"type" = "Type",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
