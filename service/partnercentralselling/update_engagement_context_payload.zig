const CustomerProjectsContext = @import("customer_projects_context.zig").CustomerProjectsContext;
const UpdateLeadContext = @import("update_lead_context.zig").UpdateLeadContext;

/// Represents the updated payload of an engagement context. The structure of
/// this payload varies based on the context type being updated.
pub const UpdateEngagementContextPayload = union(enum) {
    customer_project: ?CustomerProjectsContext,
    /// Contains updated information about a lead when the context type is "Lead".
    /// This field is present only when updating a lead context within the
    /// engagement.
    lead: ?UpdateLeadContext,

    pub const json_field_names = .{
        .customer_project = "CustomerProject",
        .lead = "Lead",
    };
};
