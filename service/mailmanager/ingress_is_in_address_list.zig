const IngressAddressListEmailAttribute = @import("ingress_address_list_email_attribute.zig").IngressAddressListEmailAttribute;

/// The address lists and the address list attribute value that is evaluated in
/// a policy statement's conditional expression to either deny or block the
/// incoming email.
pub const IngressIsInAddressList = struct {
    /// The address lists that will be used for evaluation.
    address_lists: []const []const u8,

    /// The email attribute that needs to be evaluated against the address list.
    attribute: IngressAddressListEmailAttribute,

    pub const json_field_names = .{
        .address_lists = "AddressLists",
        .attribute = "Attribute",
    };
};
