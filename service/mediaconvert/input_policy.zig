/// An input policy allows or disallows a job you submit to run based on the
/// conditions that you specify.
pub const InputPolicy = enum {
    allowed,
    disallowed,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .disallowed = "DISALLOWED",
    };
};
