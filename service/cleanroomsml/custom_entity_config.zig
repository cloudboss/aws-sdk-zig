/// The configuration for defining custom patterns to be redacted from logs and
/// error messages. This is for the CUSTOM config under entitiesToRedact. Both
/// CustomEntityConfig and entitiesToRedact need to be present or not present.
pub const CustomEntityConfig = struct {
    /// Defines data identifiers for the custom entity configuration. Provide this
    /// only if CUSTOM redaction is configured.
    custom_data_identifiers: []const []const u8,

    pub const json_field_names = .{
        .custom_data_identifiers = "customDataIdentifiers",
    };
};
