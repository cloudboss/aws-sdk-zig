const UpdatedMcpServerAdditionalDataFields = @import("updated_mcp_server_additional_data_fields.zig").UpdatedMcpServerAdditionalDataFields;

/// The MCP server additional-data patch wrapper. Omit to leave the additional
/// data unchanged; supply an empty object to remove it; supply optionalValue to
/// patch its fields.
pub const UpdatedMcpServerAdditionalData = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedMcpServerAdditionalDataFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
