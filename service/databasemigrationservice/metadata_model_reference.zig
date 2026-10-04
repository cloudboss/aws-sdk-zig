/// A reference to a metadata model, including its name and selection rules for
/// location identification.
pub const MetadataModelReference = struct {
    /// The name of the metadata model.
    metadata_model_name: ?[]const u8 = null,

    /// A JSON string that identifies this metadata model in the metadata tree. For
    /// the selection rule format, see [Selection rules in DMS Schema
    /// Conversion](https://docs.aws.amazon.com/dms/latest/userguide/sc-selection-rules.html).
    ///
    /// Usage:
    ///
    /// * You can pass this value as the `SelectionRules` parameter to any operation
    ///   that accepts selection rules, such as `DescribeMetadataModel`,
    ///   `StartMetadataModelConversion`, and others.
    selection_rules: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata_model_name = "MetadataModelName",
        .selection_rules = "SelectionRules",
    };
};
