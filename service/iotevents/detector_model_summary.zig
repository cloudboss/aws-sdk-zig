/// Information about the detector model.
pub const DetectorModelSummary = struct {
    /// The time the detector model was created.
    creation_time: ?i64,

    /// A brief description of the detector model.
    detector_model_description: ?[]const u8,

    /// The name of the detector model.
    detector_model_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .detector_model_description = "detectorModelDescription",
        .detector_model_name = "detectorModelName",
    };
};
