const DICOMStudyDateAndTime = @import("dicom_study_date_and_time.zig").DICOMStudyDateAndTime;

/// The search input attribute value.
pub const SearchByAttributeValue = union(enum) {
    /// The created at time of the image set provided for search.
    created_at: ?i64,
    /// The DICOM accession number for search.
    dicom_accession_number: ?[]const u8,
    /// The patient ID input for search.
    dicom_patient_id: ?[]const u8,
    /// The Series Instance UID input for search.
    dicom_series_instance_uid: ?[]const u8,
    /// The aggregated structure containing DICOM study date and study time for
    /// search.
    dicom_study_date_and_time: ?DICOMStudyDateAndTime,
    /// The DICOM study ID for search.
    dicom_study_id: ?[]const u8,
    /// The DICOM study instance UID for search.
    dicom_study_instance_uid: ?[]const u8,
    /// The primary image set flag provided for search.
    is_primary: ?bool,
    /// The timestamp input for search.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dicom_accession_number = "DICOMAccessionNumber",
        .dicom_patient_id = "DICOMPatientId",
        .dicom_series_instance_uid = "DICOMSeriesInstanceUID",
        .dicom_study_date_and_time = "DICOMStudyDateAndTime",
        .dicom_study_id = "DICOMStudyId",
        .dicom_study_instance_uid = "DICOMStudyInstanceUID",
        .is_primary = "isPrimary",
        .updated_at = "updatedAt",
    };
};
