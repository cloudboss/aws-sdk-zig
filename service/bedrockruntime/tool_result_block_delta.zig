/// Contains incremental updates to tool results information during streaming
/// responses. This allows clients to build up tool results data progressively
/// as the response is generated.
pub const ToolResultBlockDelta = union(enum) {
    /// The JSON schema for the tool result content block. see [JSON Schema
    /// Reference](https://json-schema.org/understanding-json-schema/reference).
    json: ?[]const u8,
    /// The reasoning the model used to return the output.
    text: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
        .text = "text",
    };
};
