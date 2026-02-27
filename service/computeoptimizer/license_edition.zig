pub const LicenseEdition = enum {
    enterprise,
    standard,
    free,
    no_license_edition_found,

    pub const json_field_names = .{
        .enterprise = "ENTERPRISE",
        .standard = "STANDARD",
        .free = "FREE",
        .no_license_edition_found = "NO_LICENSE_EDITION_FOUND",
    };
};
