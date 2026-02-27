pub const TraversalDirection = enum {
    parent,
    child,

    pub const json_field_names = .{
        .parent = "PARENT",
        .child = "CHILD",
    };
};
