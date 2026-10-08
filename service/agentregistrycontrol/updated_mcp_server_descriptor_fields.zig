const UpdatedMcpServerAdditionalData = @import("updated_mcp_server_additional_data.zig").UpdatedMcpServerAdditionalData;
const UpdatedDescriptorData = @import("updated_descriptor_data.zig").UpdatedDescriptorData;
const UpdatedDataSchemaVersion = @import("updated_data_schema_version.zig").UpdatedDataSchemaVersion;
const UpdatedDescriptorSource = @import("updated_descriptor_source.zig").UpdatedDescriptorSource;

/// The set of MCP server descriptor fields that can be individually updated.
pub const UpdatedMcpServerDescriptorFields = struct {
    /// The patch for the descriptor's additional data field.
    additional_data: ?UpdatedMcpServerAdditionalData = null,

    /// The patch for the descriptor's data field.
    data: ?UpdatedDescriptorData = null,

    /// The patch for the descriptor's data schema version field.
    data_schema_version: ?UpdatedDataSchemaVersion = null,

    /// The patch for the descriptor's source field.
    source: ?UpdatedDescriptorSource = null,

    pub const json_field_names = .{
        .additional_data = "additionalData",
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
        .source = "source",
    };
};
