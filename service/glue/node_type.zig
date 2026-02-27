pub const NodeType = enum {
    crawler,
    job,
    trigger,

    pub const json_field_names = .{
        .crawler = "CRAWLER",
        .job = "JOB",
        .trigger = "TRIGGER",
    };
};
