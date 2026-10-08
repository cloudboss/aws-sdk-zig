const MedicalScribeSessionControlEventType = @import("medical_scribe_session_control_event_type.zig").MedicalScribeSessionControlEventType;

/// An event for controlling the Medical Scribe session
pub const MedicalScribeSessionControlEvent = struct {
    /// The type of session control event
    type: ?MedicalScribeSessionControlEventType = null,

    pub const json_field_names = .{
        .type = "type",
    };
};
