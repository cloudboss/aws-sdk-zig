pub const PrivateConnectionProvisioningFailureCause = enum {
    connector_authentication,
    connector_server,
    internal_server,
    access_denied,
    validation,

    pub const json_field_names = .{
        .connector_authentication = "CONNECTOR_AUTHENTICATION",
        .connector_server = "CONNECTOR_SERVER",
        .internal_server = "INTERNAL_SERVER",
        .access_denied = "ACCESS_DENIED",
        .validation = "VALIDATION",
    };
};
