/// The full name of the user.
pub const Name = struct {
    /// The family name of the user.
    family_name: ?[]const u8 = null,

    /// A string containing a formatted version of the name for display.
    formatted: ?[]const u8 = null,

    /// The given name of the user.
    given_name: ?[]const u8 = null,

    /// The honorific prefix of the user. For example, "Dr."
    honorific_prefix: ?[]const u8 = null,

    /// The honorific suffix of the user. For example, "M.D."
    honorific_suffix: ?[]const u8 = null,

    /// The middle name of the user.
    middle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .family_name = "FamilyName",
        .formatted = "Formatted",
        .given_name = "GivenName",
        .honorific_prefix = "HonorificPrefix",
        .honorific_suffix = "HonorificSuffix",
        .middle_name = "MiddleName",
    };
};
