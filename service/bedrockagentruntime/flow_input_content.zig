/// Contains information about an input into the flow.
pub const FlowInputContent = union(enum) {
    /// The input to send to the prompt flow input node.
    document: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
    };
};
