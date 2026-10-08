/// The configuration that enables a pentest to run as part of a CI/CD pipeline,
/// scoped to the code changes in each pipeline run.
pub const CiCdConfiguration = struct {
    /// Whether CI/CD pentesting is enabled for this pentest.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
