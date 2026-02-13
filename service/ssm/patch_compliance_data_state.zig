pub const PatchComplianceDataState = enum {
    installed,
    installed_other,
    installed_pending_reboot,
    installed_rejected,
    missing,
    not_applicable,
    failed,
    available_security_update,

    pub const json_field_names = .{
        .installed = "Installed",
        .installed_other = "InstalledOther",
        .installed_pending_reboot = "InstalledPendingReboot",
        .installed_rejected = "InstalledRejected",
        .missing = "Missing",
        .not_applicable = "NotApplicable",
        .failed = "Failed",
        .available_security_update = "AvailableSecurityUpdate",
    };
};
