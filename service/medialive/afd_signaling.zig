/// Afd Signaling
pub const AfdSignaling = enum {
    auto,
    fixed,
    none,

    pub const json_field_names = .{
        .auto = "AUTO",
        .fixed = "FIXED",
        .none = "NONE",
    };
};
