pub const LicenseConfigurationStatus = enum {
    available,
    disabled,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .disabled = "DISABLED",
    };
};
