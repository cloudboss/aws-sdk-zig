/// Information about the number of nodes and node types in a vehicle network.
pub const NodeCounts = struct {
    /// The total number of nodes in a vehicle network that represent actuators.
    total_actuators: i32 = 0,

    /// The total number of nodes in a vehicle network that represent attributes.
    total_attributes: i32 = 0,

    /// The total number of nodes in a vehicle network that represent branches.
    total_branches: i32 = 0,

    /// The total number of nodes in a vehicle network.
    total_nodes: i32 = 0,

    /// The total properties for the node.
    total_properties: i32 = 0,

    /// The total number of nodes in a vehicle network that represent sensors.
    total_sensors: i32 = 0,

    /// The total structure for the node.
    total_structs: i32 = 0,

    pub const json_field_names = .{
        .total_actuators = "totalActuators",
        .total_attributes = "totalAttributes",
        .total_branches = "totalBranches",
        .total_nodes = "totalNodes",
        .total_properties = "totalProperties",
        .total_sensors = "totalSensors",
        .total_structs = "totalStructs",
    };
};
