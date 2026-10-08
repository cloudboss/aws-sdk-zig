const Pronouns = @import("pronouns.zig").Pronouns;

/// Details for a patient
pub const PatientInsightsPatientContext = struct {
    /// Date of birth of the patient.
    date_of_birth: ?[]const u8 = null,

    /// Unique identifier of the patient
    patient_id: []const u8,

    /// Pronouns preferred by the patient.
    pronouns: ?Pronouns = null,

    pub const json_field_names = .{
        .date_of_birth = "dateOfBirth",
        .patient_id = "patientId",
        .pronouns = "pronouns",
    };
};
