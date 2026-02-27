pub const SalesActivity = enum {
    initialized_discussions_with_customer,
    customer_has_shown_interest,
    conducted_poc_demo,
    in_evaluation_planning_stage,
    agreed_on_solution_to_business_problem,
    completed_action_plan,
    finalized_deployment_needs,
    sow_signed,

    pub const json_field_names = .{
        .initialized_discussions_with_customer = "INITIALIZED_DISCUSSIONS_WITH_CUSTOMER",
        .customer_has_shown_interest = "CUSTOMER_HAS_SHOWN_INTEREST",
        .conducted_poc_demo = "CONDUCTED_POC_DEMO",
        .in_evaluation_planning_stage = "IN_EVALUATION_PLANNING_STAGE",
        .agreed_on_solution_to_business_problem = "AGREED_ON_SOLUTION_TO_BUSINESS_PROBLEM",
        .completed_action_plan = "COMPLETED_ACTION_PLAN",
        .finalized_deployment_needs = "FINALIZED_DEPLOYMENT_NEEDS",
        .sow_signed = "SOW_SIGNED",
    };
};
