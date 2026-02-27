pub const TransactionType = enum {
    read_and_write,
    read_only,

    pub const json_field_names = .{
        .read_and_write = "READ_AND_WRITE",
        .read_only = "READ_ONLY",
    };
};
