const EntityState = @import("entity_state.zig").EntityState;
const MemberType = @import("member_type.zig").MemberType;

/// The representation of a user or group.
pub const Member = struct {
    /// The date indicating when the member was disabled from WorkMail use.
    disabled_date: ?i64,

    /// The date indicating when the member was enabled for WorkMail use.
    enabled_date: ?i64,

    /// The identifier of the member.
    id: ?[]const u8,

    /// The name of the member.
    name: ?[]const u8,

    /// The state of the member, which can be ENABLED, DISABLED, or DELETED.
    state: ?EntityState,

    /// A member can be a user or group.
    type: ?MemberType,

    pub const json_field_names = .{
        .disabled_date = "DisabledDate",
        .enabled_date = "EnabledDate",
        .id = "Id",
        .name = "Name",
        .state = "State",
        .type = "Type",
    };
};
