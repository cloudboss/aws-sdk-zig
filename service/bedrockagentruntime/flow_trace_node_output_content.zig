/// Contains the content of the node output. For more information, see [Track
/// each step in your prompt flow by viewing its trace in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceNodeOutputContent = union(enum) {
    /// The content of the node output.
    document: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
    };
};
