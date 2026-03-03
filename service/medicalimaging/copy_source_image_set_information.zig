const MetadataCopies = @import("metadata_copies.zig").MetadataCopies;

/// Copy source image set information.
pub const CopySourceImageSetInformation = struct {
    /// Contains `MetadataCopies` structure and wraps information related to
    /// specific copy use cases. For example, when copying subsets.
    dicom_copies: ?MetadataCopies = null,

    /// The latest version identifier for the source image set.
    latest_version_id: []const u8,

    pub const json_field_names = .{
        .dicom_copies = "DICOMCopies",
        .latest_version_id = "latestVersionId",
    };
};
