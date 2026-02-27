pub const IngestionRequestSource = enum {
    manual,
    scheduled,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .scheduled = "SCHEDULED",
    };
};
