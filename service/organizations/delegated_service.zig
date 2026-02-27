/// Contains information about the Amazon Web Services service for which the
/// account is a delegated
/// administrator.
pub const DelegatedService = struct {
    /// The date that the account became a delegated administrator for this service.
    delegation_enabled_date: ?i64,

    /// The name of an Amazon Web Services service that can request an operation for
    /// the specified service.
    /// This is typically in the form of a URL, such as:
    /// `
    /// *servicename*.amazonaws.com`.
    service_principal: ?[]const u8,

    pub const json_field_names = .{
        .delegation_enabled_date = "DelegationEnabledDate",
        .service_principal = "ServicePrincipal",
    };
};
