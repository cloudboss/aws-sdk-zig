const EntityState = @import("entity_state.zig").EntityState;

/// Filtering options for *ListGroups* operation. This is only used as input to
/// Operation.
pub const ListGroupsFilters = struct {
    /// Filters only groups with the provided name prefix.
    name_prefix: ?[]const u8 = null,

    /// Filters only groups with the provided primary email prefix.
    primary_email_prefix: ?[]const u8 = null,

    /// Filters only groups with the provided state.
    state: ?EntityState = null,

    pub const json_field_names = .{
        .name_prefix = "NamePrefix",
        .primary_email_prefix = "PrimaryEmailPrefix",
        .state = "State",
    };
};
