/// Context information about the clinical encounter
pub const EncounterContext = struct {
    /// Unstructured context information in markdown format
    unstructured_context: ?[]const u8 = null,

    pub const json_field_names = .{
        .unstructured_context = "unstructuredContext",
    };
};
