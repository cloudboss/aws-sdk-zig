const Account = @import("account.zig").Account;
const Contact = @import("contact.zig").Contact;

/// An object that contains the customer's `Account` and `Contact`.
pub const Customer = struct {
    /// An object that contains the customer's account details.
    account: ?Account = null,

    /// Represents the contact details for individuals associated with the customer
    /// of the `Opportunity`. This field captures relevant contacts, including
    /// decision-makers, influencers, and technical stakeholders within the customer
    /// organization. These contacts are key to progressing the opportunity.
    contacts: ?[]const Contact = null,

    pub const json_field_names = .{
        .account = "Account",
        .contacts = "Contacts",
    };
};
