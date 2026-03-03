const MedicalScribePatientContext = @import("medical_scribe_patient_context.zig").MedicalScribePatientContext;

/// The `MedicalScribeContext` object that contains contextual information which
/// is used during clinical note generation
/// to add relevant context to the note.
pub const MedicalScribeContext = struct {
    /// Contains patient-specific information used to customize the clinical note
    /// generation.
    patient_context: ?MedicalScribePatientContext = null,

    pub const json_field_names = .{
        .patient_context = "PatientContext",
    };
};
