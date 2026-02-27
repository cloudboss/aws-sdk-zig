pub const HLSDiscontinuityMode = enum {
    always,
    never,
    on_discontinuity,

    pub const json_field_names = .{
        .always = "ALWAYS",
        .never = "NEVER",
        .on_discontinuity = "ON_DISCONTINUITY",
    };
};
