pub const PreferenceType = enum {
    no_preference,
    custom_preference,

    pub const json_field_names = .{
        .no_preference = "NO_PREFERENCE",
        .custom_preference = "CUSTOM_PREFERENCE",
    };
};
