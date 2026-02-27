pub const ContentRedactionType = enum {
    pii,

    pub const json_field_names = .{
        .pii = "PII",
    };
};
