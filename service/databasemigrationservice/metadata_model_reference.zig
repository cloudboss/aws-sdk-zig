/// A reference to a metadata model, including its name and selection rules for
/// location identification.
pub const MetadataModelReference = struct {
    /// The name of the metadata model.
    metadata_model_name: ?[]const u8 = null,

    /// The JSON string representing metadata model location.
    selection_rules: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata_model_name = "MetadataModelName",
        .selection_rules = "SelectionRules",
    };
};
