const UpdatedDescriptorData = @import("updated_descriptor_data.zig").UpdatedDescriptorData;
const UpdatedDataSchemaVersion = @import("updated_data_schema_version.zig").UpdatedDataSchemaVersion;
const UpdatedDescriptorSource = @import("updated_descriptor_source.zig").UpdatedDescriptorSource;

/// The set of agent skills markdown descriptor fields that can be individually
/// updated.
pub const UpdatedAgentSkillsMdDescriptorFields = struct {
    /// The patch for the descriptor's data field.
    data: ?UpdatedDescriptorData = null,

    /// The patch for the descriptor's data schema version field.
    data_schema_version: ?UpdatedDataSchemaVersion = null,

    /// The patch for the descriptor's source field.
    source: ?UpdatedDescriptorSource = null,

    pub const json_field_names = .{
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
        .source = "source",
    };
};
