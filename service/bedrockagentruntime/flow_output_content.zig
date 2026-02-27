/// Contains information about the content in an output from prompt flow
/// invocation.
pub const FlowOutputContent = union(enum) {
    /// The content in the output.
    document: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
    };
};
