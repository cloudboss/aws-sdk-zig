const EngagementCustomer = @import("engagement_customer.zig").EngagementCustomer;
const ProjectDetails = @import("project_details.zig").ProjectDetails;
const ReceiverResponsibility = @import("receiver_responsibility.zig").ReceiverResponsibility;
const SenderContact = @import("sender_contact.zig").SenderContact;

/// Represents the data payload of an Engagement Invitation for a specific
/// opportunity. This contains detailed information that partners use to
/// evaluate the engagement.
pub const OpportunityInvitationPayload = struct {
    /// Contains information about the customer related to the opportunity in the
    /// Engagement Invitation. This data helps partners understand the customer’s
    /// profile and requirements.
    customer: EngagementCustomer,

    /// Describes the project details associated with the opportunity, including the
    /// customer’s needs and the scope of work expected to be performed.
    project: ProjectDetails,

    /// Outlines the responsibilities or expectations of the receiver in the context
    /// of the invitation.
    receiver_responsibilities: []const ReceiverResponsibility,

    /// Represents the contact details of the AWS representatives involved in
    /// sending the Engagement Invitation. These contacts are opportunity
    /// stakeholders.
    sender_contacts: ?[]const SenderContact,

    pub const json_field_names = .{
        .customer = "Customer",
        .project = "Project",
        .receiver_responsibilities = "ReceiverResponsibilities",
        .sender_contacts = "SenderContacts",
    };
};
