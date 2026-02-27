/// Statistics about a label used in a dataset. For more information, see
/// DatasetLabelDescription.
pub const DatasetLabelStats = struct {
    /// The total number of images that have the label assigned to a bounding box.
    bounding_box_count: ?i32,

    /// The total number of images that use the label.
    entry_count: ?i32,

    pub const json_field_names = .{
        .bounding_box_count = "BoundingBoxCount",
        .entry_count = "EntryCount",
    };
};
