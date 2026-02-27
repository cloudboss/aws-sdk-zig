pub const CsvHeaderOption = enum {
    unknown,
    present,
    absent,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .present = "PRESENT",
        .absent = "ABSENT",
    };
};
