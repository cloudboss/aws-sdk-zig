const PortType = @import("port_type.zig").PortType;

/// A node output port.
pub const NodeOutputPort = struct {
    /// The output port's description.
    description: ?[]const u8,

    /// The output port's name.
    name: ?[]const u8,

    /// The output port's type.
    type: ?PortType,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .type = "Type",
    };
};
