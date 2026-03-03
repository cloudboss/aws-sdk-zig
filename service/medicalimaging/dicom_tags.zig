/// The DICOM attributes returned as a part of a response. Each image set has
/// these properties as part of a search result.
pub const DICOMTags = struct {
    /// The accession number for the DICOM study.
    dicom_accession_number: ?[]const u8 = null,

    /// The total number of instances in the DICOM study.
    dicom_number_of_study_related_instances: i32 = 0,

    /// The total number of series in the DICOM study.
    dicom_number_of_study_related_series: i32 = 0,

    /// The patient birth date.
    dicom_patient_birth_date: ?[]const u8 = null,

    /// The unique identifier for a patient in a DICOM Study.
    dicom_patient_id: ?[]const u8 = null,

    /// The patient name.
    dicom_patient_name: ?[]const u8 = null,

    /// The patient sex.
    dicom_patient_sex: ?[]const u8 = null,

    /// The DICOM provided identifier for the series Body Part Examined.
    dicom_series_body_part: ?[]const u8 = null,

    /// The DICOM provided identifier for the Series Instance UID.
    dicom_series_instance_uid: ?[]const u8 = null,

    /// The DICOM provided identifier for the series Modality.
    dicom_series_modality: ?[]const u8 = null,

    /// The DICOM provided identifier for the Series Number.
    dicom_series_number: ?i32 = null,

    /// The study date.
    dicom_study_date: ?[]const u8 = null,

    /// The DICOM provided Study Description.
    dicom_study_description: ?[]const u8 = null,

    /// The DICOM provided identifier for the Study ID.
    dicom_study_id: ?[]const u8 = null,

    /// The DICOM provided identifier for the Study Instance UID.
    dicom_study_instance_uid: ?[]const u8 = null,

    /// The study time.
    dicom_study_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .dicom_accession_number = "DICOMAccessionNumber",
        .dicom_number_of_study_related_instances = "DICOMNumberOfStudyRelatedInstances",
        .dicom_number_of_study_related_series = "DICOMNumberOfStudyRelatedSeries",
        .dicom_patient_birth_date = "DICOMPatientBirthDate",
        .dicom_patient_id = "DICOMPatientId",
        .dicom_patient_name = "DICOMPatientName",
        .dicom_patient_sex = "DICOMPatientSex",
        .dicom_series_body_part = "DICOMSeriesBodyPart",
        .dicom_series_instance_uid = "DICOMSeriesInstanceUID",
        .dicom_series_modality = "DICOMSeriesModality",
        .dicom_series_number = "DICOMSeriesNumber",
        .dicom_study_date = "DICOMStudyDate",
        .dicom_study_description = "DICOMStudyDescription",
        .dicom_study_id = "DICOMStudyId",
        .dicom_study_instance_uid = "DICOMStudyInstanceUID",
        .dicom_study_time = "DICOMStudyTime",
    };
};
