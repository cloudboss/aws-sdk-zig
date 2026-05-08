/// Maps DCM files to their metadata.
pub const DicomMetadataMapping = struct {
    /// The path to the JSON metadata file relative to inputS3Uri.
    metadata_file_path: []const u8,

    /// The Series Instance UID that identifies the series. This parameter is
    /// optional because the mapping might be at the study level.
    series_instance_uid: ?[]const u8 = null,

    /// The Study Instance UID that identifies the study.
    study_instance_uid: []const u8,

    pub const json_field_names = .{
        .metadata_file_path = "metadataFilePath",
        .series_instance_uid = "seriesInstanceUID",
        .study_instance_uid = "studyInstanceUID",
    };
};
