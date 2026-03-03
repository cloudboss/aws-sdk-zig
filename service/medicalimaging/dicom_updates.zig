/// The object containing `removableAttributes` and `updatableAttributes`.
pub const DICOMUpdates = struct {
    /// The DICOM tags to be removed from `ImageSetMetadata`.
    removable_attributes: ?[]const u8 = null,

    /// The DICOM tags that need to be updated in `ImageSetMetadata`.
    updatable_attributes: ?[]const u8 = null,

    pub const json_field_names = .{
        .removable_attributes = "removableAttributes",
        .updatable_attributes = "updatableAttributes",
    };
};
