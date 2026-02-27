/// Smpte2038 Data Preference
pub const Smpte2038DataPreference = enum {
    ignore,
    prefer,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .prefer = "PREFER",
    };
};
