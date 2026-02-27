/// The configuration for an application to automatically start on job
/// submission.
pub const AutoStartConfig = struct {
    /// Enables the application to automatically start on job submission. Defaults
    /// to true.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
