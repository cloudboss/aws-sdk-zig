pub const SsmDocumentType = enum {
    automation,
    command,

    pub const json_field_names = .{
        .automation = "AUTOMATION",
        .command = "COMMAND",
    };
};
