const CanDbcDefinition = @import("can_dbc_definition.zig").CanDbcDefinition;

/// Specifications for defining a vehicle network.
pub const NetworkFileDefinition = union(enum) {
    /// Information, including CAN DBC files, about the configurations used to
    /// create a
    /// decoder manifest.
    can_dbc: ?CanDbcDefinition,

    pub const json_field_names = .{
        .can_dbc = "canDbc",
    };
};
