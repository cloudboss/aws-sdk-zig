const DicomJsonMetadataImportConfiguration = @import("dicom_json_metadata_import_configuration.zig").DicomJsonMetadataImportConfiguration;

/// The configuration options for different types of import operations.
pub const ImportConfiguration = union(enum) {
    dicom_json_metadata_import_configuration: ?DicomJsonMetadataImportConfiguration,

    pub const json_field_names = .{
        .dicom_json_metadata_import_configuration = "dicomJsonMetadataImportConfiguration",
    };
};
