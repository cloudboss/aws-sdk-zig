/// The representation of an organization.
pub const OrganizationSummary = struct {
    /// The alias associated with the organization.
    alias: ?[]const u8,

    /// The default email domain associated with the organization.
    default_mail_domain: ?[]const u8,

    /// The error message associated with the organization. It is only present if
    /// unexpected
    /// behavior has occurred with regards to the organization. It provides insight
    /// or solutions
    /// regarding unexpected behavior.
    error_message: ?[]const u8,

    /// The identifier associated with the organization.
    organization_id: ?[]const u8,

    /// The state associated with the organization.
    state: ?[]const u8,

    pub const json_field_names = .{
        .alias = "Alias",
        .default_mail_domain = "DefaultMailDomain",
        .error_message = "ErrorMessage",
        .organization_id = "OrganizationId",
        .state = "State",
    };
};
