pub const X12SplitBy = enum {
    none,
    transaction,

    pub const json_field_names = .{
        .none = "NONE",
        .transaction = "TRANSACTION",
    };
};
