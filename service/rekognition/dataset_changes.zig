/// Describes updates or additions to a dataset. A Single update or addition
/// is an entry (JSON Line) that provides information about a single image. To
/// update an existing entry,
/// you match the `source-ref` field of the update entry with the `source-ref`
/// filed of the entry that you want to update.
/// If the `source-ref` field doesn't match an existing entry, the entry is
/// added to dataset as a new entry.
pub const DatasetChanges = struct {
    /// A Base64-encoded binary data object
    /// containing one or JSON lines that either update the dataset or are additions
    /// to the dataset. You change a dataset by calling UpdateDatasetEntries.
    /// If you are using an AWS SDK to call `UpdateDatasetEntries`, you don't need
    /// to encode `Changes` as the SDK encodes the data for you.
    ///
    /// For example JSON lines,
    /// see Image-Level labels in manifest files and
    /// and Object localization in manifest files in the *Amazon Rekognition Custom
    /// Labels Developer Guide*.
    ground_truth: []const u8,

    pub const json_field_names = .{
        .ground_truth = "GroundTruth",
    };
};
