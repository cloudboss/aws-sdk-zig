/// Details about duplicate connections found between two nodes in the flow.
pub const DuplicateConnectionsFlowValidationDetails = struct {
    /// The name of the source node where the duplicate connection starts.
    source: []const u8,

    /// The name of the target node where the duplicate connection ends.
    target: []const u8,

    pub const json_field_names = .{
        .source = "source",
        .target = "target",
    };
};
