/// Details on the criteria used to define the filter for a vulnerability
/// search.
pub const SearchVulnerabilitiesFilterCriteria = struct {
    /// The IDs for specific vulnerabilities.
    vulnerability_ids: []const []const u8,

    pub const json_field_names = .{
        .vulnerability_ids = "vulnerabilityIds",
    };
};
