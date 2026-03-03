const DICOMTags = @import("dicom_tags.zig").DICOMTags;
const StorageTier = @import("storage_tier.zig").StorageTier;

/// Summary of the image set metadata.
pub const ImageSetsMetadataSummary = struct {
    /// The time an image set is created. Sample creation date is provided in
    /// `1985-04-12T23:20:50.52Z` format.
    created_at: ?i64 = null,

    /// The DICOM tags associated with the image set.
    dicom_tags: ?DICOMTags = null,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The flag to determine whether the image set is primary or not.
    is_primary: ?bool = null,

    /// When the image set was last accessed.
    last_accessed_at: ?i64 = null,

    /// The image set's storage tier.
    storage_tier: ?StorageTier = null,

    /// The time an image set was last updated.
    updated_at: ?i64 = null,

    /// The image set version.
    version: ?i32 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dicom_tags = "DICOMTags",
        .image_set_id = "imageSetId",
        .is_primary = "isPrimary",
        .last_accessed_at = "lastAccessedAt",
        .storage_tier = "storageTier",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
