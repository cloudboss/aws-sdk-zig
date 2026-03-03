const DeliveryModel = @import("delivery_model.zig").DeliveryModel;
const ExpectedCustomerSpend = @import("expected_customer_spend.zig").ExpectedCustomerSpend;
const SalesActivity = @import("sales_activity.zig").SalesActivity;

/// Provides the project view of an opportunity resource shared through a
/// snapshot.
pub const ProjectView = struct {
    /// Specifies the proposed solution focus or type of workload for the project.
    customer_use_case: ?[]const u8 = null,

    /// Describes the deployment or consumption model for the partner solution or
    /// offering. This field indicates how the project's solution will be delivered
    /// or implemented for the customer.
    delivery_models: ?[]const DeliveryModel = null,

    /// Provides information about the anticipated customer spend related to this
    /// project. This may include details such as amount, frequency, and currency of
    /// expected expenditure.
    expected_customer_spend: ?[]const ExpectedCustomerSpend = null,

    /// Offers a description of other solutions if the standard solutions do not
    /// adequately cover the project's scope.
    other_solution_description: ?[]const u8 = null,

    /// Lists the pre-sales activities that have occurred with the end-customer
    /// related to the opportunity. This field is conditionally mandatory when the
    /// project is qualified for Co-Sell and helps drive assignment priority on the
    /// AWS side. It provides insight into the engagement level with the customer.
    sales_activities: ?[]const SalesActivity = null,

    pub const json_field_names = .{
        .customer_use_case = "CustomerUseCase",
        .delivery_models = "DeliveryModels",
        .expected_customer_spend = "ExpectedCustomerSpend",
        .other_solution_description = "OtherSolutionDescription",
        .sales_activities = "SalesActivities",
    };
};
