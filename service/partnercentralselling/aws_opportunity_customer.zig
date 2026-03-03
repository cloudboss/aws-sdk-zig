const Contact = @import("contact.zig").Contact;

/// Represents the customer associated with the AWS opportunity. This field
/// captures key details about the customer that are necessary for managing the
/// opportunity.
pub const AwsOpportunityCustomer = struct {
    /// Provides a list of customer contacts involved in the opportunity. These
    /// contacts may include decision makers, influencers, and other stakeholders
    /// within the customer's organization.
    contacts: ?[]const Contact = null,

    pub const json_field_names = .{
        .contacts = "Contacts",
    };
};
