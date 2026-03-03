const SpaceSettings = @import("space_settings.zig").SpaceSettings;

pub const UpdateSpaceRequest = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// The name of the space that appears in the Amazon SageMaker Studio UI.
    space_display_name: ?[]const u8 = null,

    /// The name of the space.
    space_name: []const u8,

    /// A collection of space settings.
    space_settings: ?SpaceSettings = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings = "SpaceSettings",
    };
};
