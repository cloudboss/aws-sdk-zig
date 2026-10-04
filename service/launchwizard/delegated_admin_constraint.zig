/// The deployment must be initiated from a delegated administrator account for
/// the specified service principal.
pub const DelegatedAdminConstraint = struct {
    /// The service principal for which the account must be a delegated
    /// administrator. For example, `stacksets.cloudformation.amazonaws.com`.
    service_principal: []const u8,

    pub const json_field_names = .{
        .service_principal = "servicePrincipal",
    };
};
