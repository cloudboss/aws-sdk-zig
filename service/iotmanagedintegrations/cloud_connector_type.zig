pub const CloudConnectorType = enum {
    listed,
    unlisted,

    pub const json_field_names = .{
        .listed = "LISTED",
        .unlisted = "UNLISTED",
    };
};
