pub const QueryLanguage = enum {
    cwli,
    sql,
    ppl,

    pub const json_field_names = .{
        .cwli = "CWLI",
        .sql = "SQL",
        .ppl = "PPL",
    };
};
