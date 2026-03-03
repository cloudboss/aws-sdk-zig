const EngagementCustomer = @import("engagement_customer.zig").EngagementCustomer;
const EngagementCustomerProjectDetails = @import("engagement_customer_project_details.zig").EngagementCustomerProjectDetails;

/// The CustomerProjects structure in Engagements offers a flexible framework
/// for managing customer-project relationships. It supports multiple customers
/// per Engagement and multiple projects per customer, while also allowing for
/// customers without projects and projects without specific customers.
///
/// All Engagement members have full visibility of customers and their
/// associated projects, enabling the capture of relevant context even when
/// project details are not fully defined. This structure also facilitates
/// targeted invitations, allowing partners to focus on specific customers and
/// their business problems when sending Engagement invitations.
pub const CustomerProjectsContext = struct {
    customer: ?EngagementCustomer = null,

    /// Information about the customer project associated with the Engagement.
    project: ?EngagementCustomerProjectDetails = null,

    pub const json_field_names = .{
        .customer = "Customer",
        .project = "Project",
    };
};
