/// The content structure containing input information for multi-turn flow
/// interactions.
pub const FlowMultiTurnInputContent = union(enum) {
    /// The requested additional input to send back to the multi-turn flow node.
    document: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
    };
};
