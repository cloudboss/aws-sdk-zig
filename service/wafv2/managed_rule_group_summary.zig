/// High-level information about a managed rule group, returned by
/// ListAvailableManagedRuleGroups. This provides information like the name and
/// vendor name, that you provide when you add a ManagedRuleGroupStatement to a
/// web ACL. Managed rule groups include Amazon Web Services Managed Rules rule
/// groups and Amazon Web Services Marketplace managed rule groups. To use any
/// Amazon Web Services Marketplace managed rule group, first subscribe to the
/// rule group through Amazon Web Services Marketplace.
pub const ManagedRuleGroupSummary = struct {
    /// The description of the managed rule group, provided by Amazon Web Services
    /// Managed Rules or the Amazon Web Services Marketplace seller who manages it.
    description: ?[]const u8 = null,

    /// The name of the managed rule group. You use this, along with the vendor
    /// name, to identify the rule group.
    name: ?[]const u8 = null,

    /// The name of the managed rule group vendor. You use this, along with the rule
    /// group name, to identify a rule group.
    vendor_name: ?[]const u8 = null,

    /// Indicates whether the managed rule group is versioned. If it is, you can
    /// retrieve the
    /// versions list by calling ListAvailableManagedRuleGroupVersions.
    versioning_supported: bool = false,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .vendor_name = "VendorName",
        .versioning_supported = "VersioningSupported",
    };
};
