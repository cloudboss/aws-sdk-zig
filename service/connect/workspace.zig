const aws = @import("aws");

const WorkspaceTheme = @import("workspace_theme.zig").WorkspaceTheme;
const Visibility = @import("visibility.zig").Visibility;

/// Contains information about a workspace, which defines the user experience by
/// mapping views to pages.
pub const Workspace = struct {
    /// The Amazon Resource Name (ARN) of the workspace.
    arn: []const u8,

    /// The description of the workspace.
    description: ?[]const u8,

    /// The unique identifier of the workspace.
    id: []const u8,

    /// The Amazon Web Services Region where the workspace was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when the workspace was last modified.
    last_modified_time: i64,

    /// The name of the workspace.
    name: []const u8,

    /// The tags used to organize, track, or control access for the workspace.
    tags: ?[]const aws.map.StringMapEntry,

    /// The theme configuration for the workspace, including colors and styling.
    theme: ?WorkspaceTheme,

    /// The title displayed for the workspace.
    title: ?[]const u8,

    /// Controls who can access the workspace. Valid values are: `ALL` (all users),
    /// `ASSIGNED`
    /// (only assigned users and routing profiles), and `NONE` (not visible).
    visibility: ?Visibility,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .tags = "Tags",
        .theme = "Theme",
        .title = "Title",
        .visibility = "Visibility",
    };
};
