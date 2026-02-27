/// Specifies the configuration for cold storage options such as enabled
pub const ColdStorageOptions = struct {
    /// Enable cold storage option. Accepted values true or false
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
