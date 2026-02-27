pub const OrderKey = enum {
    ascending,
    descending,

    pub const json_field_names = .{
        .ascending = "Ascending",
        .descending = "Descending",
    };
};
