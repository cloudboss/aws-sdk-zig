/// Represents the contact details of the individual assigned to manage the
/// opportunity within the partner organization. This helps to ensure that there
/// is a point of contact for the opportunity's progress.
pub const AssigneeContact = struct {
    /// Specifies the business title of the assignee managing the opportunity. This
    /// helps clarify the individual's role and responsibilities within the
    /// organization. Use the value `PartnerAccountManager` to update details of the
    /// opportunity owner.
    business_title: []const u8,

    /// Provides the email address of the assignee. This email is used for
    /// communications and notifications related to the opportunity.
    email: []const u8,

    /// Specifies the first name of the assignee managing the opportunity. The
    /// system automatically retrieves this value from the user profile by
    /// referencing the associated email address.
    first_name: []const u8,

    /// Specifies the last name of the assignee managing the opportunity. The system
    /// automatically retrieves this value from the user profile by referencing the
    /// associated email address.
    last_name: []const u8,

    /// Specifies the contact phone number of the assignee responsible for the
    /// opportunity or engagement. This field enables direct communication for
    /// time-sensitive matters and facilitates coordination between AWS and partner
    /// teams.
    phone: ?[]const u8,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .phone = "Phone",
    };
};
