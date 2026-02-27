pub const FieldName = enum {
    crawl_id,
    state,
    start_time,
    end_time,
    dpu_hour,

    pub const json_field_names = .{
        .crawl_id = "CRAWL_ID",
        .state = "STATE",
        .start_time = "START_TIME",
        .end_time = "END_TIME",
        .dpu_hour = "DPU_HOUR",
    };
};
