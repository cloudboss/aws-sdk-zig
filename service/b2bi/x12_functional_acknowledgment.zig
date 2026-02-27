pub const X12FunctionalAcknowledgment = enum {
    do_not_generate,
    generate_all_segments,
    generate_without_transaction_set_response_loop,

    pub const json_field_names = .{
        .do_not_generate = "DO_NOT_GENERATE",
        .generate_all_segments = "GENERATE_ALL_SEGMENTS",
        .generate_without_transaction_set_response_loop = "GENERATE_WITHOUT_TRANSACTION_SET_RESPONSE_LOOP",
    };
};
