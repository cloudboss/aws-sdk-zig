const DomainUnitGroupProperties = @import("domain_unit_group_properties.zig").DomainUnitGroupProperties;
const DomainUnitUserProperties = @import("domain_unit_user_properties.zig").DomainUnitUserProperties;

/// The properties of the domain unit owner.
pub const DomainUnitOwnerProperties = union(enum) {
    /// Indicates that the domain unit owner is a group.
    group: ?DomainUnitGroupProperties,
    /// Indicates that the domain unit owner is a user.
    user: ?DomainUnitUserProperties,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};
