/// A custom descriptor for a registry record. Use this for resources such as
/// APIs, Lambda functions, or servers that do not conform to a standard
/// protocol like MCP or A2A.
pub const CustomDescriptor = struct {
    /// The custom descriptor content as a valid JSON document. You can define any
    /// custom schema that describes your resource.
    inline_content: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
    };
};
