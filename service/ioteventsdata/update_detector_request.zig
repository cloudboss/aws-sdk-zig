const DetectorStateDefinition = @import("detector_state_definition.zig").DetectorStateDefinition;

/// Information used to update the detector (instance).
pub const UpdateDetectorRequest = struct {
    /// The name of the detector model that created the detectors (instances).
    detector_model_name: []const u8,

    /// The value of the input key attribute (identifying the device or system) that
    /// caused the
    /// creation of this detector (instance).
    key_value: ?[]const u8 = null,

    /// The ID to assign to the detector update `"message"`. Each
    /// `"messageId"` must be unique within each batch sent.
    message_id: []const u8,

    /// The new state, variable values, and timer settings of the detector
    /// (instance).
    state: DetectorStateDefinition,

    pub const json_field_names = .{
        .detector_model_name = "detectorModelName",
        .key_value = "keyValue",
        .message_id = "messageId",
        .state = "state",
    };
};
