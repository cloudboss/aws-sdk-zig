pub const LicenseModel = enum {
    bring_your_own_license,
    license_included,

    pub const json_field_names = .{
        .bring_your_own_license = "BRING_YOUR_OWN_LICENSE",
        .license_included = "LICENSE_INCLUDED",
    };
};
