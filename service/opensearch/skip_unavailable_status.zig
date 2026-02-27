/// The status of `SkipUnavailable` setting for the outbound connection.
///
/// * **ENABLED** - The `SkipUnavailable`
/// setting is enabled for the connection.
///
/// * **DISABLED** - The `SkipUnavailable`
/// setting is disabled for the connection.
pub const SkipUnavailableStatus = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
