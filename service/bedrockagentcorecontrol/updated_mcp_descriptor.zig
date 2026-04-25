const UpdatedMcpDescriptorFields = @import("updated_mcp_descriptor_fields.zig").UpdatedMcpDescriptorFields;

/// Wrapper for updating an MCP descriptor with PATCH semantics. When present
/// with a value, individual MCP fields can be updated independently. When
/// present with a null value, the entire MCP descriptor is unset. When absent,
/// the MCP descriptor is left unchanged.
pub const UpdatedMcpDescriptor = struct {
    /// The updated MCP descriptor fields.
    optional_value: ?UpdatedMcpDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
