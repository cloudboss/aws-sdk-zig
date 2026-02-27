pub const Compatibility = enum {
    none,
    disabled,
    backward,
    backward_all,
    forward,
    forward_all,
    full,
    full_all,

    pub const json_field_names = .{
        .none = "NONE",
        .disabled = "DISABLED",
        .backward = "BACKWARD",
        .backward_all = "BACKWARD_ALL",
        .forward = "FORWARD",
        .forward_all = "FORWARD_ALL",
        .full = "FULL",
        .full_all = "FULL_ALL",
    };
};
