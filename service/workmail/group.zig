const EntityState = @import("entity_state.zig").EntityState;

/// The representation of an WorkMail group.
pub const Group = struct {
    /// The date indicating when the group was disabled from WorkMail use.
    disabled_date: ?i64 = null,

    /// The email of the group.
    email: ?[]const u8 = null,

    /// The date indicating when the group was enabled for WorkMail use.
    enabled_date: ?i64 = null,

    /// The identifier of the group.
    id: ?[]const u8 = null,

    /// The name of the group.
    name: ?[]const u8 = null,

    /// The state of the group, which can be ENABLED, DISABLED, or DELETED.
    state: ?EntityState = null,

    pub const json_field_names = .{
        .disabled_date = "DisabledDate",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .id = "Id",
        .name = "Name",
        .state = "State",
    };
};
