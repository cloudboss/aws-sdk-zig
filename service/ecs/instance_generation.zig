pub const InstanceGeneration = enum {
    current,
    previous,

    pub const json_field_names = .{
        .current = "CURRENT",
        .previous = "PREVIOUS",
    };
};
