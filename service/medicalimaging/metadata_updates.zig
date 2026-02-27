const DICOMUpdates = @import("dicom_updates.zig").DICOMUpdates;

/// Contains DICOMUpdates.
pub const MetadataUpdates = union(enum) {
    /// The object containing `removableAttributes` and `updatableAttributes`.
    dicom_updates: ?DICOMUpdates,
    /// Specifies the previous image set version ID to revert the current image set
    /// back to.
    ///
    /// You must provide either `revertToVersionId` or `DICOMUpdates` in your
    /// request. A `ValidationException` error is thrown if both parameters are
    /// provided at the same time.
    revert_to_version_id: ?[]const u8,

    pub const json_field_names = .{
        .dicom_updates = "DICOMUpdates",
        .revert_to_version_id = "revertToVersionId",
    };
};
