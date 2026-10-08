const UpdatedDescriptorData = @import("updated_descriptor_data.zig").UpdatedDescriptorData;
const UpdatedDataSchemaVersion = @import("updated_data_schema_version.zig").UpdatedDataSchemaVersion;

/// The set of MCP tools descriptor fields that can be individually updated.
pub const UpdatedMcpToolsDescriptorFields = struct {
    /// The patch for the descriptor's data field.
    data: ?UpdatedDescriptorData = null,

    /// The patch for the descriptor's data schema version field.
    data_schema_version: ?UpdatedDataSchemaVersion = null,

    pub const json_field_names = .{
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
    };
};
