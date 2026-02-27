pub const ChronologicalOrder = enum {
    reverse,
    forward,

    pub const json_field_names = .{
        .reverse = "Reverse",
        .forward = "Forward",
    };
};
