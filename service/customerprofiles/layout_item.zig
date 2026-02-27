const aws = @import("aws");

const LayoutType = @import("layout_type.zig").LayoutType;

/// The layout object that contains LayoutDefinitionName, Description,
/// DisplayName,
/// IsDefault, LayoutType, Tags, CreatedAt, LastUpdatedAt
pub const LayoutItem = struct {
    /// The timestamp of when the layout was created.
    created_at: i64,

    /// The description of the layout
    description: []const u8,

    /// The display name of the layout
    display_name: []const u8,

    /// If set to true for a layout, this layout will be used by default to view
    /// data. If set to
    /// false, then layout will not be used by default but it can be used to view
    /// data by explicit
    /// selection on UI.
    is_default: bool = false,

    /// The timestamp of when the layout was most recently updated.
    last_updated_at: i64,

    /// The unique name of the layout.
    layout_definition_name: []const u8,

    /// The type of layout that can be used to view data under customer profiles
    /// domain.
    layout_type: LayoutType,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .is_default = "IsDefault",
        .last_updated_at = "LastUpdatedAt",
        .layout_definition_name = "LayoutDefinitionName",
        .layout_type = "LayoutType",
        .tags = "Tags",
    };
};
