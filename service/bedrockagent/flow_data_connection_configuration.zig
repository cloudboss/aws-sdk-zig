/// The configuration of a connection originating from a node that isn't a
/// Condition node.
pub const FlowDataConnectionConfiguration = struct {
    /// The name of the output in the source node that the connection begins from.
    source_output: []const u8,

    /// The name of the input in the target node that the connection ends at.
    target_input: []const u8,

    pub const json_field_names = .{
        .source_output = "sourceOutput",
        .target_input = "targetInput",
    };
};
