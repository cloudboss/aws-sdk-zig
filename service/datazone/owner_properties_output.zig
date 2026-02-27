const OwnerGroupPropertiesOutput = @import("owner_group_properties_output.zig").OwnerGroupPropertiesOutput;
const OwnerUserPropertiesOutput = @import("owner_user_properties_output.zig").OwnerUserPropertiesOutput;

/// The ID of the domain unit owners group.
pub const OwnerPropertiesOutput = union(enum) {
    /// Specifies that the domain unit owner is a group.
    group: ?OwnerGroupPropertiesOutput,
    /// Specifies that the domain unit owner is a user.
    user: ?OwnerUserPropertiesOutput,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};
