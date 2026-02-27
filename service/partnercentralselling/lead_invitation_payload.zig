const LeadInvitationCustomer = @import("lead_invitation_customer.zig").LeadInvitationCustomer;
const LeadInvitationInteraction = @import("lead_invitation_interaction.zig").LeadInvitationInteraction;

/// Represents the data payload of an engagement invitation for a lead
/// opportunity. This contains detailed information about the customer and
/// interaction history that partners use to evaluate whether to accept the lead
/// engagement invitation.
pub const LeadInvitationPayload = struct {
    /// Contains information about the customer associated with the lead invitation.
    /// This data helps partners understand the customer's profile, industry, and
    /// business context to assess the lead opportunity.
    customer: LeadInvitationCustomer,

    /// Describes the interaction details associated with the lead, including the
    /// source of the lead generation and customer engagement information. This
    /// context helps partners evaluate the lead quality and engagement approach.
    interaction: LeadInvitationInteraction,

    pub const json_field_names = .{
        .customer = "Customer",
        .interaction = "Interaction",
    };
};
