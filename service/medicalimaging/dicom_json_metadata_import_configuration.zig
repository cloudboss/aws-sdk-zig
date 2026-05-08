const DicomMetadataMapping = @import("dicom_metadata_mapping.zig").DicomMetadataMapping;

/// The configuration parameters that are specific to DICOM JSON metadata import
/// operations.
pub const DicomJsonMetadataImportConfiguration = struct {
    /// Maps DCM files to their metadata.
    dicom_metadata_mappings: []const DicomMetadataMapping,

    pub const json_field_names = .{
        .dicom_metadata_mappings = "dicomMetadataMappings",
    };
};
