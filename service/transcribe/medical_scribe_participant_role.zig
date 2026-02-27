pub const MedicalScribeParticipantRole = enum {
    patient,
    clinician,

    pub const json_field_names = .{
        .patient = "PATIENT",
        .clinician = "CLINICIAN",
    };
};
