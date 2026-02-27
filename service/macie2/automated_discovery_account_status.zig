/// The status of automated sensitive data discovery for an Amazon Macie
/// account. Valid values are:
pub const AutomatedDiscoveryAccountStatus = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
