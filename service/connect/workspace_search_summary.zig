const aws = @import("aws");

const Visibility = @import("visibility.zig").Visibility;

/// Contains summary information about a workspace returned from a search
/// operation.
pub const WorkspaceSearchSummary = struct {
    /// The Amazon Resource Name (ARN) of the workspace.
    arn: ?[]const u8,

    /// The timestamp when the workspace was created.
    created_at: ?i64,

    /// The description of the workspace.
    description: ?[]const u8,

    /// The unique identifier of the workspace.
    id: ?[]const u8,

    /// The name of the workspace.
    name: ?[]const u8,

    /// The tags associated with the workspace.
    tags: ?[]const aws.map.StringMapEntry,

    /// The title displayed for the workspace.
    title: ?[]const u8,

    /// The visibility setting of the workspace.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .tags = "Tags",
        .title = "Title",
        .visibility = "Visibility",
    };
};
