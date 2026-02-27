const IdMappingType = @import("id_mapping_type.zig").IdMappingType;

/// The settings for the ID namespace for the ID mapping workflow job.
pub const IdNamespaceIdMappingWorkflowMetadata = struct {
    /// The type of ID mapping.
    id_mapping_type: IdMappingType,

    pub const json_field_names = .{
        .id_mapping_type = "idMappingType",
    };
};
