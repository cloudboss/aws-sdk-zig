pub const IncompatibleLoopNodeType = enum {
    input,
    condition,
    iterator,
    collector,

    pub const json_field_names = .{
        .input = "INPUT",
        .condition = "CONDITION",
        .iterator = "ITERATOR",
        .collector = "COLLECTOR",
    };
};
