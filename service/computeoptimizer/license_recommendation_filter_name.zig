pub const LicenseRecommendationFilterName = enum {
    license_finding,
    license_finding_reason_code,
    license_name,

    pub const json_field_names = .{
        .license_finding = "LICENSE_FINDING",
        .license_finding_reason_code = "LICENSE_FINDING_REASON_CODE",
        .license_name = "LICENSE_NAME",
    };
};
