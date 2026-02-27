/// Contains the content of an flow execution input or output field.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowExecutionContent = union(enum) {
    /// The document content of the field, which can contain text or structured
    /// data.
    document: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
    };
};
