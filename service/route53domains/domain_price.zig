const PriceWithCurrency = @import("price_with_currency.zig").PriceWithCurrency;

/// Information about the prices associated with a TLD or a domain name.
pub const DomainPrice = struct {
    /// The price for changing domain ownership.
    change_ownership_price: ?PriceWithCurrency = null,

    /// The TLD or domain name that the prices apply to.
    name: ?[]const u8 = null,

    /// The price for domain registration with Route 53.
    registration_price: ?PriceWithCurrency = null,

    /// The price for renewing domain registration with Route 53.
    renewal_price: ?PriceWithCurrency = null,

    /// The price for restoring the domain with Route 53.
    restoration_price: ?PriceWithCurrency = null,

    /// The price for transferring the domain registration to Route 53.
    transfer_price: ?PriceWithCurrency = null,

    pub const json_field_names = .{
        .change_ownership_price = "ChangeOwnershipPrice",
        .name = "Name",
        .registration_price = "RegistrationPrice",
        .renewal_price = "RenewalPrice",
        .restoration_price = "RestorationPrice",
        .transfer_price = "TransferPrice",
    };
};
