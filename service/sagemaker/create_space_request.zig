const OwnershipSettings = @import("ownership_settings.zig").OwnershipSettings;
const SpaceSettings = @import("space_settings.zig").SpaceSettings;
const SpaceSharingSettings = @import("space_sharing_settings.zig").SpaceSharingSettings;
const Tag = @import("tag.zig").Tag;

pub const CreateSpaceRequest = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// A collection of ownership settings.
    ownership_settings: ?OwnershipSettings,

    /// The name of the space that appears in the SageMaker Studio UI.
    space_display_name: ?[]const u8,

    /// The name of the space.
    space_name: []const u8,

    /// A collection of space settings.
    space_settings: ?SpaceSettings,

    /// A collection of space sharing settings.
    space_sharing_settings: ?SpaceSharingSettings,

    /// Tags to associated with the space. Each tag consists of a key and an
    /// optional value. Tag keys must be unique for each resource. Tags are
    /// searchable using the `Search` API.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .ownership_settings = "OwnershipSettings",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings = "SpaceSettings",
        .space_sharing_settings = "SpaceSharingSettings",
        .tags = "Tags",
    };
};
