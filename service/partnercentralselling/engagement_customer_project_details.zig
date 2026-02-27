/// Provides comprehensive details about a customer project associated with an
/// Engagement. This may include information such as project goals, timelines,
/// and specific customer requirements.
pub const EngagementCustomerProjectDetails = struct {
    /// A description of the business problem the project aims to solve.
    business_problem: []const u8,

    /// The target completion date for the customer's project.
    target_completion_date: []const u8,

    /// The title of the project.
    title: []const u8,

    pub const json_field_names = .{
        .business_problem = "BusinessProblem",
        .target_completion_date = "TargetCompletionDate",
        .title = "Title",
    };
};
