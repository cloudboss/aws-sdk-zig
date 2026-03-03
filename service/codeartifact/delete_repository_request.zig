pub const DeleteRepositoryRequest = struct {
    /// The name of the domain that contains the repository to delete.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The name of the repository to delete.
    repository: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .repository = "repository",
    };
};
