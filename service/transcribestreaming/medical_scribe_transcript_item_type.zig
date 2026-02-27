pub const MedicalScribeTranscriptItemType = enum {
    pronunciation,
    punctuation,

    pub const json_field_names = .{
        .pronunciation = "PRONUNCIATION",
        .punctuation = "PUNCTUATION",
    };
};
