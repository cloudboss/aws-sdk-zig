const OwnerGroupProperties = @import("owner_group_properties.zig").OwnerGroupProperties;
const OwnerUserProperties = @import("owner_user_properties.zig").OwnerUserProperties;

/// The properties of a domain unit's owner.
pub const OwnerProperties = union(enum) {
    /// Specifies that the domain unit owner is a group.
    group: ?OwnerGroupProperties,
    /// Specifies that the domain unit owner is a user.
    user: ?OwnerUserProperties,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};
