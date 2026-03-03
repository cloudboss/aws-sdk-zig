/// If your IPAM is integrated with Amazon Web Services Organizations and you
/// add an organizational unit (OU) exclusion, IPAM will not manage the IP
/// addresses in accounts in that OU exclusion.
pub const IpamOrganizationalUnitExclusion = struct {
    /// An Amazon Web Services Organizations entity path. For more information on
    /// the entity path, see [Understand the Amazon Web Services Organizations
    /// entity
    /// path](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_last-accessed-view-data-orgs.html#access_policies_access-advisor-viewing-orgs-entity-path) in the *Amazon Web Services Identity and Access Management User Guide*.
    organizations_entity_path: ?[]const u8 = null,
};
