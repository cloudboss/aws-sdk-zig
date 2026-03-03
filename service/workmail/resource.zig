const EntityState = @import("entity_state.zig").EntityState;
const ResourceType = @import("resource_type.zig").ResourceType;

/// The representation of a resource.
pub const Resource = struct {
    /// Resource description.
    description: ?[]const u8 = null,

    /// The date indicating when the resource was disabled from WorkMail use.
    disabled_date: ?i64 = null,

    /// The email of the resource.
    email: ?[]const u8 = null,

    /// The date indicating when the resource was enabled for WorkMail use.
    enabled_date: ?i64 = null,

    /// The identifier of the resource.
    id: ?[]const u8 = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The state of the resource, which can be ENABLED, DISABLED, or DELETED.
    state: ?EntityState = null,

    /// The type of the resource: equipment or room.
    @"type": ?ResourceType = null,

    pub const json_field_names = .{
        .description = "Description",
        .disabled_date = "DisabledDate",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .id = "Id",
        .name = "Name",
        .state = "State",
        .@"type" = "Type",
    };
};
