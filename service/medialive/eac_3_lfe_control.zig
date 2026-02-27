/// Eac3 Lfe Control
pub const Eac3LfeControl = enum {
    lfe,
    no_lfe,

    pub const json_field_names = .{
        .lfe = "LFE",
        .no_lfe = "NO_LFE",
    };
};
