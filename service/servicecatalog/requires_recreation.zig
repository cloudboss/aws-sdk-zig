pub const RequiresRecreation = enum {
    never,
    conditionally,
    always,

    pub const json_field_names = .{
        .never = "NEVER",
        .conditionally = "CONDITIONALLY",
        .always = "ALWAYS",
    };
};
