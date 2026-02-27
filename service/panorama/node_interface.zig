const NodeInputPort = @import("node_input_port.zig").NodeInputPort;
const NodeOutputPort = @import("node_output_port.zig").NodeOutputPort;

/// A node interface.
pub const NodeInterface = struct {
    /// The node interface's inputs.
    inputs: []const NodeInputPort,

    /// The node interface's outputs.
    outputs: []const NodeOutputPort,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .outputs = "Outputs",
    };
};
