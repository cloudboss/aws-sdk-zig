/// Specifies if DevOps Guru is enabled to create an Amazon Web Services Systems
/// Manager OpsItem for each created
/// insight.
pub const OptInStatus = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
