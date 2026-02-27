pub const DataFormat = enum {
    csv,
    jsonl,
    orc,

    pub const json_field_names = .{
        .csv = "CSV",
        .jsonl = "JSONL",
        .orc = "ORC",
    };
};
