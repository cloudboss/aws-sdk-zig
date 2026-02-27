const MedicalScribePatientContext = @import("medical_scribe_patient_context.zig").MedicalScribePatientContext;

/// The `MedicalScribeContext` object that contains contextual information used
/// to generate
/// customized clinical notes.
pub const MedicalScribeContext = struct {
    /// Contains patient-specific information.
    patient_context: ?MedicalScribePatientContext,

    pub const json_field_names = .{
        .patient_context = "PatientContext",
    };
};
