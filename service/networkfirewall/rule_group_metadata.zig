/// High-level information about a rule group, returned by ListRuleGroups.
/// You can use the information provided in the metadata to retrieve and manage
/// a
/// rule group.
pub const RuleGroupMetadata = struct {
    /// The Amazon Resource Name (ARN) of the rule group.
    arn: ?[]const u8 = null,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    name: ?[]const u8 = null,

    /// The name of the Amazon Web Services Marketplace seller that provides this
    /// rule group.
    vendor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .vendor_name = "VendorName",
    };
};
