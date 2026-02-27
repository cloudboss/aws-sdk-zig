const CustomerProjectsContext = @import("customer_projects_context.zig").CustomerProjectsContext;
const LeadContext = @import("lead_context.zig").LeadContext;

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

    pub const json_field_names = .{
        .customer_project = "CustomerProject",
        .lead = "Lead",
    };
};
