const RuleAddressListEmailAttribute = @import("rule_address_list_email_attribute.zig").RuleAddressListEmailAttribute;

/// The structure type for a boolean condition that provides the address lists
/// and address list attribute to evaluate.
pub const RuleIsInAddressList = struct {
    /// The address lists that will be used for evaluation.
    address_lists: []const []const u8,

    /// The email attribute that needs to be evaluated against the address list.
    attribute: RuleAddressListEmailAttribute,

    pub const json_field_names = .{
        .address_lists = "AddressLists",
        .attribute = "Attribute",
    };
};
