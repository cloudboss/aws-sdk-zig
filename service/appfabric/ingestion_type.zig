pub const IngestionType = enum {
    audit_log,

    pub const json_field_names = .{
        .audit_log = "AUDIT_LOG",
    };
};
