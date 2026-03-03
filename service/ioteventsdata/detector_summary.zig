const DetectorStateSummary = @import("detector_state_summary.zig").DetectorStateSummary;

/// Information about the detector (instance).
pub const DetectorSummary = struct {
    /// The time the detector (instance) was created.
    creation_time: ?i64 = null,

    /// The name of the detector model that created this detector (instance).
    detector_model_name: ?[]const u8 = null,

    /// The version of the detector model that created this detector (instance).
    detector_model_version: ?[]const u8 = null,

    /// The value of the key (identifying the device or system) that caused the
    /// creation of this
    /// detector (instance).
    key_value: ?[]const u8 = null,

    /// The time the detector (instance) was last updated.
    last_update_time: ?i64 = null,

    /// The current state of the detector (instance).
    state: ?DetectorStateSummary = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .detector_model_name = "detectorModelName",
        .detector_model_version = "detectorModelVersion",
        .key_value = "keyValue",
        .last_update_time = "lastUpdateTime",
        .state = "state",
    };
};
