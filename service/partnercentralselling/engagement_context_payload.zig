const CustomerProjectsContext = @import("customer_projects_context.zig").CustomerProjectsContext;
const LeadContext = @import("lead_context.zig").LeadContext;
const ProspectingResult = @import("prospecting_result.zig").ProspectingResult;

/// Represents the payload of an Engagement context. The structure of this
/// payload varies based on the context type specified in the
/// EngagementContextDetails.
pub const EngagementContextPayload = union(enum) {
    /// Contains detailed information about a customer project when the context type
    /// is "CustomerProject". This field is present only when the Type in
    /// EngagementContextDetails is set to "CustomerProject".
    customer_project: ?CustomerProjectsContext,
    /// Contains detailed information about a lead when the context type is "Lead".
    /// This field is present only when the Type in EngagementContextDetails is set
    /// to "Lead".
    lead: ?LeadContext,
    /// Contains prospecting result data with enriched insights. The system
    /// generates these insights when a partner runs an autonomous prospecting job
    /// on leads. This field appears only when the context type is
    /// "ProspectingResult".
    prospecting_result: ?ProspectingResult,

    pub const json_field_names = .{
        .customer_project = "CustomerProject",
        .lead = "Lead",
        .prospecting_result = "ProspectingResult",
    };
};
