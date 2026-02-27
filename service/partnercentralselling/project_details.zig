const ExpectedCustomerSpend = @import("expected_customer_spend.zig").ExpectedCustomerSpend;

/// Contains details about the project associated with the Engagement
/// Invitation, including the business problem and expected outcomes.
pub const ProjectDetails = struct {
    /// Describes the business problem that the project aims to solve. This
    /// information is crucial for understanding the project’s goals and objectives.
    business_problem: []const u8,

    /// Contains revenue estimates for the partner related to the project. This
    /// field provides an idea of the financial potential of the opportunity for the
    /// partner.
    expected_customer_spend: []const ExpectedCustomerSpend,

    /// Specifies the estimated date of project completion. This field helps track
    /// the project timeline and manage expectations.
    target_completion_date: []const u8,

    /// Specifies the title of the project. This title helps partners quickly
    /// identify and understand the focus of the project.
    title: []const u8,

    pub const json_field_names = .{
        .business_problem = "BusinessProblem",
        .expected_customer_spend = "ExpectedCustomerSpend",
        .target_completion_date = "TargetCompletionDate",
        .title = "Title",
    };
};
