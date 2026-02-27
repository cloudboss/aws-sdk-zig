const FirewallDomainImportOperation = @import("firewall_domain_import_operation.zig").FirewallDomainImportOperation;

pub const ImportFirewallDomainsRequest = struct {
    /// The fully qualified URL or URI of the file stored in Amazon Simple Storage
    /// Service
    /// (Amazon S3) that contains the list of domains to import.
    ///
    /// The file must be in an S3 bucket that's in the same Region
    /// as your DNS Firewall. The file must be a text file and must contain a single
    /// domain per line.
    domain_file_url: []const u8,

    /// The ID of the domain list that you want to modify with the import operation.
    firewall_domain_list_id: []const u8,

    /// What you want DNS Firewall to do with the domains that are listed in the
    /// file. This must be set to `REPLACE`, which updates the domain list to
    /// exactly match the list in the file.
    operation: FirewallDomainImportOperation,

    pub const json_field_names = .{
        .domain_file_url = "DomainFileUrl",
        .firewall_domain_list_id = "FirewallDomainListId",
        .operation = "Operation",
    };
};
