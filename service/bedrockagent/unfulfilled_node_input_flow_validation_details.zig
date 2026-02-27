/// Details about an unfulfilled node input with no valid connections.
pub const UnfulfilledNodeInputFlowValidationDetails = struct {
    /// The name of the unfulfilled input. An input is unfulfilled if there are no
    /// data connections to it.
    input: []const u8,

    /// The name of the node containing the unfulfilled input.
    node: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .node = "node",
    };
};
