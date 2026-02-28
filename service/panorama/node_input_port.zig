const PortType = @import("port_type.zig").PortType;

/// A node input port.
pub const NodeInputPort = struct {
    /// The input port's default value.
    default_value: ?[]const u8,

    /// The input port's description.
    description: ?[]const u8,

    /// The input port's max connections.
    max_connections: i32 = 0,

    /// The input port's name.
    name: ?[]const u8,

    /// The input port's type.
    @"type": ?PortType,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .description = "Description",
        .max_connections = "MaxConnections",
        .name = "Name",
        .@"type" = "Type",
    };
};
