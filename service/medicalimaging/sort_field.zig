pub const SortField = enum {
    updated_at,
    created_at,
    dicom_study_date_and_time,

    pub const json_field_names = .{
        .updated_at = "updatedAt",
        .created_at = "createdAt",
        .dicom_study_date_and_time = "DICOMStudyDateAndTime",
    };
};
