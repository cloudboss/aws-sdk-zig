/// A source IP addresses and address range to inspect for.
pub const RuleGroupSourceStatelessRuleMatchAttributesSources = struct {
    /// An IP address or a block of IP addresses.
    address_definition: ?[]const u8,

    pub const json_field_names = .{
        .address_definition = "AddressDefinition",
    };
};
