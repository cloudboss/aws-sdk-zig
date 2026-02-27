/// Represents interaction details included in a lead invitation payload. This
/// structure provides context about how the lead was generated and the
/// customer's engagement history to help partners assess the opportunity
/// quality.
pub const LeadInvitationInteraction = struct {
    /// The business title or job role of the customer contact involved in the lead
    /// interaction. This helps partners identify the decision-making level and
    /// engagement approach for the lead.
    contact_business_title: []const u8,

    /// The unique identifier of the specific source that generated the lead
    /// interaction. This provides traceability to the original lead generation
    /// activity for reference and follow-up purposes.
    source_id: []const u8,

    /// The descriptive name of the source that generated the lead interaction. This
    /// human-readable identifier helps partners understand the specific lead
    /// generation channel or campaign that created the opportunity.
    source_name: []const u8,

    /// Specifies the type of source that generated the lead interaction, such as
    /// "Event", "Website", or "Campaign". This helps partners understand the lead
    /// generation channel and assess lead quality based on the source type.
    source_type: []const u8,

    /// Describes the specific use case or business scenario associated with the
    /// lead interaction. This information helps partners understand the customer's
    /// interests and potential solution requirements.
    usecase: ?[]const u8,

    pub const json_field_names = .{
        .contact_business_title = "ContactBusinessTitle",
        .source_id = "SourceId",
        .source_name = "SourceName",
        .source_type = "SourceType",
        .usecase = "Usecase",
    };
};
