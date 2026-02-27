pub const LicenseModel = enum {
    license_included,
    bring_your_own_license,

    pub const json_field_names = .{
        .license_included = "LICENSE_INCLUDED",
        .bring_your_own_license = "BRING_YOUR_OWN_LICENSE",
    };
};
