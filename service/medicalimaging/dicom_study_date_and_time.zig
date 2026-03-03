/// The aggregated structure to store DICOM study date and study time for search
/// capabilities.
pub const DICOMStudyDateAndTime = struct {
    /// The DICOM study date provided in `yyMMdd` format.
    dicom_study_date: []const u8,

    /// The DICOM study time provided in `HHmmss.FFFFFF` format.
    dicom_study_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .dicom_study_date = "DICOMStudyDate",
        .dicom_study_time = "DICOMStudyTime",
    };
};
