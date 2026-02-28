const ViewType = @import("view_type.zig").ViewType;

/// A summary of a view version's metadata.
pub const ViewVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the view version.
    arn: ?[]const u8,

    /// The description of the view version.
    description: ?[]const u8,

    /// The identifier of the view version.
    id: ?[]const u8,

    /// The name of the view version.
    name: ?[]const u8,

    /// The type of the view version.
    type: ?ViewType,

    /// The sequentially incremented version of the view version.
    version: i32 = 0,

    /// The description of the view version.
    version_description: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .type = "Type",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
