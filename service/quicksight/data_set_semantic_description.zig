/// A description structure for dataset-level semantic metadata.
pub const DataSetSemanticDescription = struct {
    /// The descriptive text for the dataset.
    text: []const u8,

    pub const json_field_names = .{
        .text = "Text",
    };
};
