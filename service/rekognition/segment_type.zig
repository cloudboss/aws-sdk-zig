pub const SegmentType = enum {
    technical_cue,
    shot,

    pub const json_field_names = .{
        .technical_cue = "TECHNICAL_CUE",
        .shot = "SHOT",
    };
};
