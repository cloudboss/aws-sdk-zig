const DetectorModelConfiguration = @import("detector_model_configuration.zig").DetectorModelConfiguration;
const DetectorModelDefinition = @import("detector_model_definition.zig").DetectorModelDefinition;

/// Information about the detector model.
pub const DetectorModel = struct {
    /// Information about how the detector is configured.
    detector_model_configuration: ?DetectorModelConfiguration = null,

    /// Information that defines how a detector operates.
    detector_model_definition: ?DetectorModelDefinition = null,

    pub const json_field_names = .{
        .detector_model_configuration = "detectorModelConfiguration",
        .detector_model_definition = "detectorModelDefinition",
    };
};
