pub const MessageSelectionStrategy = enum {
    random,
    ordered,

    pub const json_field_names = .{
        .random = "Random",
        .ordered = "Ordered",
    };
};
