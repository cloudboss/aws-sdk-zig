/// The detector model and the specific detectors (instances) for which the
/// logging level is
/// given.
pub const DetectorDebugOption = struct {
    /// The name of the detector model.
    detector_model_name: []const u8,

    /// The value of the input attribute key used to create the detector (the
    /// instance of the
    /// detector model).
    key_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .detector_model_name = "detectorModelName",
        .key_value = "keyValue",
    };
};
