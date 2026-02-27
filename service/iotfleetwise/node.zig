const Actuator = @import("actuator.zig").Actuator;
const Attribute = @import("attribute.zig").Attribute;
const Branch = @import("branch.zig").Branch;
const CustomProperty = @import("custom_property.zig").CustomProperty;
const Sensor = @import("sensor.zig").Sensor;
const CustomStruct = @import("custom_struct.zig").CustomStruct;

/// A general abstraction of a signal. A node can be specified as an actuator,
/// attribute,
/// branch, or sensor.
pub const Node = union(enum) {
    /// Information about a node specified as an actuator.
    ///
    /// An actuator is a digital representation of a vehicle device.
    actuator: ?Actuator,
    /// Information about a node specified as an attribute.
    ///
    /// An attribute represents static information about a vehicle.
    attribute: ?Attribute,
    /// Information about a node specified as a branch.
    ///
    /// A group of signals that are defined in a hierarchical structure.
    branch: ?Branch,
    /// Represents a member of the complex data structure. The `datatype` of the
    /// property can be either primitive or another `struct`.
    property: ?CustomProperty,
    sensor: ?Sensor,
    /// Represents a complex or higher-order data structure.
    @"struct": ?CustomStruct,

    pub const json_field_names = .{
        .actuator = "actuator",
        .attribute = "attribute",
        .branch = "branch",
        .property = "property",
        .sensor = "sensor",
        .@"struct" = "struct",
    };
};
