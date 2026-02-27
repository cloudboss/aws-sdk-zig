pub const TranscribeMedicalSpecialty = enum {
    primarycare,
    cardiology,
    neurology,
    oncology,
    radiology,
    urology,

    pub const json_field_names = .{
        .primarycare = "PRIMARYCARE",
        .cardiology = "CARDIOLOGY",
        .neurology = "NEUROLOGY",
        .oncology = "ONCOLOGY",
        .radiology = "RADIOLOGY",
        .urology = "UROLOGY",
    };
};
