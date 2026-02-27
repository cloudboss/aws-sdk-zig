pub const TriggerMode = enum {
    always,
    rising_edge,

    pub const json_field_names = .{
        .always = "ALWAYS",
        .rising_edge = "RISING_EDGE",
    };
};
