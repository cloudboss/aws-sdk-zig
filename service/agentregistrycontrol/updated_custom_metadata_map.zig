/// The custom metadata patch wrapper. Omit to leave the existing metadata
/// unchanged; supply with a null value to clear all metadata; supply with
/// key-value pairs to replace the existing metadata.
pub const UpdatedCustomMetadataMap = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
