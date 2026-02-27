/// When encoding 3/2 audio, controls whether the LFE channel is enabled
pub const Eac3LfeControl = enum {
    lfe,
    no_lfe,

    pub const json_field_names = .{
        .lfe = "LFE",
        .no_lfe = "NO_LFE",
    };
};
