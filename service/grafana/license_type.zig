pub const LicenseType = enum {
    /// Grafana Enterprise License.
    enterprise,
    /// Grafana Enterprise Free Trial License.
    enterprise_free_trial,

    pub const json_field_names = .{
        .enterprise = "ENTERPRISE",
        .enterprise_free_trial = "ENTERPRISE_FREE_TRIAL",
    };
};
