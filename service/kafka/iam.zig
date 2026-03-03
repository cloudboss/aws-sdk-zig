/// Details for IAM access control.
pub const Iam = struct {
    /// Indicates whether IAM access control is enabled.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
