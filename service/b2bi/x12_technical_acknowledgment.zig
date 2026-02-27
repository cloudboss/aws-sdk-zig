pub const X12TechnicalAcknowledgment = enum {
    do_not_generate,
    generate_all_segments,

    pub const json_field_names = .{
        .do_not_generate = "DO_NOT_GENERATE",
        .generate_all_segments = "GENERATE_ALL_SEGMENTS",
    };
};
