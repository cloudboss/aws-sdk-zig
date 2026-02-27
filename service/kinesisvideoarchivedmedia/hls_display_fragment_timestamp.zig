pub const HLSDisplayFragmentTimestamp = enum {
    always,
    never,

    pub const json_field_names = .{
        .always = "ALWAYS",
        .never = "NEVER",
    };
};
