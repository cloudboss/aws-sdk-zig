const UpdatedMcpServerDescriptorFields = @import("updated_mcp_server_descriptor_fields.zig").UpdatedMcpServerDescriptorFields;

/// The MCP server descriptor patch wrapper. Omit to leave the descriptor
/// unchanged; supply an empty object to remove it; supply optionalValue to
/// patch its fields.
pub const UpdatedMcpServerDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedMcpServerDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
