/// The status of the automated sensitive data discovery configuration for an
/// organization in Amazon Macie or a standalone Macie account. Valid values
/// are:
pub const AutomatedDiscoveryStatus = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
