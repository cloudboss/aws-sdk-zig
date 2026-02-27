pub const entityStatusCode = enum {
    impaired,
    unimpaired,
    unknown,
    pending,
    resolved,

    pub const json_field_names = .{
        .impaired = "IMPAIRED",
        .unimpaired = "UNIMPAIRED",
        .unknown = "UNKNOWN",
        .pending = "PENDING",
        .resolved = "RESOLVED",
    };
};
