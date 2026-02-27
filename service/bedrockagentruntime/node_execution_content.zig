/// Contains the content of a flow node's input or output field for a flow
/// execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const NodeExecutionContent = union(enum) {
    /// The document content of the field, which can contain text or structured
    /// data.
    document: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
    };
};
