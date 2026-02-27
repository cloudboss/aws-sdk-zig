/// Optional. When you request a list of presets, you can choose to list them
/// alphabetically by NAME or chronologically by CREATION_DATE. If you don't
/// specify, the service will list them by name.
pub const PresetListBy = enum {
    name,
    creation_date,
    system,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_date = "CREATION_DATE",
        .system = "SYSTEM",
    };
};
