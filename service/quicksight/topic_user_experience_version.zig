pub const TopicUserExperienceVersion = enum {
    legacy,
    new_reader_experience,

    pub const json_field_names = .{
        .legacy = "LEGACY",
        .new_reader_experience = "NEW_READER_EXPERIENCE",
    };
};
