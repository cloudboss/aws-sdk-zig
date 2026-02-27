const DetectorState = @import("detector_state.zig").DetectorState;

/// Information about the detector (instance).
pub const Detector = struct {
    /// The time the detector (instance) was created.
    creation_time: ?i64,

    /// The name of the detector model that created this detector (instance).
    detector_model_name: ?[]const u8,

    /// The version of the detector model that created this detector (instance).
    detector_model_version: ?[]const u8,

    /// The value of the key (identifying the device or system) that caused the
    /// creation of this
    /// detector (instance).
    key_value: ?[]const u8,

    /// The time the detector (instance) was last updated.
    last_update_time: ?i64,

    /// The current state of the detector (instance).
    state: ?DetectorState,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .detector_model_name = "detectorModelName",
        .detector_model_version = "detectorModelVersion",
        .key_value = "keyValue",
        .last_update_time = "lastUpdateTime",
        .state = "state",
    };
};
