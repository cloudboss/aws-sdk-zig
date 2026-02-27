/// Optionally configure a Snowflake role. Otherwise the default user role will
/// be used.
pub const SnowflakeRoleConfiguration = struct {
    /// Enable Snowflake role
    enabled: ?bool,

    /// The Snowflake role you wish to configure
    snowflake_role: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .snowflake_role = "SnowflakeRole",
    };
};
