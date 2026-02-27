/// Represents the next node that receives output data from a flow trace.
pub const FlowTraceNodeOutputNext = struct {
    /// The name of the input field in the next node that receives the data.
    input_field_name: []const u8,

    /// The name of the next node that receives the output data.
    node_name: []const u8,

    pub const json_field_names = .{
        .input_field_name = "inputFieldName",
        .node_name = "nodeName",
    };
};
