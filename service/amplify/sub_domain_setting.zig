/// Describes the settings for the subdomain.
pub const SubDomainSetting = struct {
    /// The branch name setting for the subdomain.
    branch_name: []const u8,

    /// The prefix setting for the subdomain.
    prefix: []const u8,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .prefix = "prefix",
    };
};
