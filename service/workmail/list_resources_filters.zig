const EntityState = @import("entity_state.zig").EntityState;

/// Filtering options for *ListResources* operation. This is only used as input
/// to Operation.
pub const ListResourcesFilters = struct {
    /// Filters only resource that start with the entered name prefix .
    name_prefix: ?[]const u8 = null,

    /// Filters only resource with the provided primary email prefix.
    primary_email_prefix: ?[]const u8 = null,

    /// Filters only resource with the provided state.
    state: ?EntityState = null,

    pub const json_field_names = .{
        .name_prefix = "NamePrefix",
        .primary_email_prefix = "PrimaryEmailPrefix",
        .state = "State",
    };
};
