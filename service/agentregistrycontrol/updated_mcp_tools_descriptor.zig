const UpdatedMcpToolsDescriptorFields = @import("updated_mcp_tools_descriptor_fields.zig").UpdatedMcpToolsDescriptorFields;

/// The MCP tools descriptor patch wrapper. Omit to leave the tools descriptor
/// unchanged; supply an empty object to remove it; supply optionalValue to
/// patch its fields.
pub const UpdatedMcpToolsDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedMcpToolsDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
