pub const LicenseFindingReasonCode = enum {
    cw_app_insights_disabled,
    cw_app_insights_error,
    license_over_provisioned,
    optimized,

    pub const json_field_names = .{
        .cw_app_insights_disabled = "CW_APP_INSIGHTS_DISABLED",
        .cw_app_insights_error = "CW_APP_INSIGHTS_ERROR",
        .license_over_provisioned = "LICENSE_OVER_PROVISIONED",
        .optimized = "OPTIMIZED",
    };
};
