/// Eac3 Passthrough Control
pub const Eac3PassthroughControl = enum {
    no_passthrough,
    when_possible,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .when_possible = "WHEN_POSSIBLE",
    };
};
