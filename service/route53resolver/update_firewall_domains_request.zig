const FirewallDomainUpdateOperation = @import("firewall_domain_update_operation.zig").FirewallDomainUpdateOperation;

pub const UpdateFirewallDomainsRequest = struct {
    /// A list of domains to use in the update operation.
    ///
    /// There is a limit of 1000 domains per request.
    ///
    /// Each domain specification in your domain list must satisfy the following
    /// requirements:
    ///
    /// * It can optionally start with `*` (asterisk).
    ///
    /// * With the exception of the optional starting asterisk, it must only contain
    /// the following characters: `A-Z`, `a-z`,
    /// `0-9`, `-` (hyphen).
    ///
    /// * It must be from 1-255 characters in length.
    domains: []const []const u8,

    /// The ID of the domain list whose domains you want to update.
    firewall_domain_list_id: []const u8,

    /// What you want DNS Firewall to do with the domains that you are providing:
    ///
    /// * `ADD` - Add the domains to the ones that are already in the domain list.
    ///
    /// * `REMOVE` - Search the domain list for the domains and remove them from the
    ///   list.
    ///
    /// * `REPLACE` - Update the domain list to exactly match the list that you are
    ///   providing.
    operation: FirewallDomainUpdateOperation,

    pub const json_field_names = .{
        .domains = "Domains",
        .firewall_domain_list_id = "FirewallDomainListId",
        .operation = "Operation",
    };
};
