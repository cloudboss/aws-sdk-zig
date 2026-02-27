const LeadContact = @import("lead_contact.zig").LeadContact;

/// Represents a specific interaction or touchpoint with a lead customer. This
/// structure captures details about communications, meetings, or other
/// engagement activities that help track the lead's progression and engagement
/// history.
pub const LeadInteraction = struct {
    /// Describes the business problem or challenge that the customer discussed
    /// during the interaction. This information helps qualify the lead and identify
    /// appropriate solutions.
    business_problem: ?[]const u8,

    /// Contains contact information for the customer representative involved in the
    /// lead interaction, including their name, title, and contact details.
    contact: LeadContact,

    /// Describes the action taken by the customer during or as a result of the
    /// interaction, such as requesting information, scheduling a meeting, or
    /// expressing interest in a solution.
    customer_action: []const u8,

    /// The date and time when the lead interaction occurred, in ISO 8601 format
    /// (UTC). This timestamp helps track the chronology of lead engagement
    /// activities.
    interaction_date: ?i64,

    /// The unique identifier of the specific source that generated the lead
    /// interaction. This ID provides traceability back to the original lead
    /// generation activity.
    source_id: []const u8,

    /// The descriptive name of the source that generated the lead interaction,
    /// providing a human-readable identifier for the lead generation channel or
    /// activity.
    source_name: []const u8,

    /// Specifies the type of source that generated the lead interaction, such as
    /// "Event", "Website", "Referral", or "Campaign". This categorization helps
    /// track lead generation effectiveness across different channels.
    source_type: []const u8,

    /// Describes the specific use case or business scenario discussed during the
    /// lead interaction. This helps categorize the customer's interests and
    /// potential solutions.
    usecase: ?[]const u8,

    pub const json_field_names = .{
        .business_problem = "BusinessProblem",
        .contact = "Contact",
        .customer_action = "CustomerAction",
        .interaction_date = "InteractionDate",
        .source_id = "SourceId",
        .source_name = "SourceName",
        .source_type = "SourceType",
        .usecase = "Usecase",
    };
};
