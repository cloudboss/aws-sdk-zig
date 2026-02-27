pub const ScheduleEntryType = enum {
    program,
    filler_slate,
    alternate_media,

    pub const json_field_names = .{
        .program = "PROGRAM",
        .filler_slate = "FILLER_SLATE",
        .alternate_media = "ALTERNATE_MEDIA",
    };
};
