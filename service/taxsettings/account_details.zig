const AccountMetaData = @import("account_meta_data.zig").AccountMetaData;
const TaxInheritanceDetails = @import("tax_inheritance_details.zig").TaxInheritanceDetails;
const TaxRegistrationWithJurisdiction = @import("tax_registration_with_jurisdiction.zig").TaxRegistrationWithJurisdiction;

/// An object with your `accountId` and TRN information.
pub const AccountDetails = struct {
    /// List of unique account identifiers.
    account_id: ?[]const u8,

    /// The meta data information associated with the account.
    account_meta_data: ?AccountMetaData,

    /// Tax inheritance information associated with the account.
    tax_inheritance_details: ?TaxInheritanceDetails,

    /// Your TRN information. Instead of having full legal address, here TRN
    /// information will have
    /// jurisdiction details (for example, country code and state/region/province if
    /// applicable).
    tax_registration: ?TaxRegistrationWithJurisdiction,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_meta_data = "accountMetaData",
        .tax_inheritance_details = "taxInheritanceDetails",
        .tax_registration = "taxRegistration",
    };
};
