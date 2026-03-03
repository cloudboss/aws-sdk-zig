const std = @import("std");

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
        .initialized_discussions_with_customer = "Initialized discussions with customer",
        .customer_has_shown_interest = "Customer has shown interest in solution",
        .conducted_poc_demo = "Conducted POC / Demo",
        .in_evaluation_planning_stage = "In evaluation / planning stage",
        .agreed_on_solution_to_business_problem = "Agreed on solution to Business Problem",
        .completed_action_plan = "Completed Action Plan",
        .finalized_deployment_needs = "Finalized Deployment Need",
        .sow_signed = "SOW Signed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initialized_discussions_with_customer => "Initialized discussions with customer",
            .customer_has_shown_interest => "Customer has shown interest in solution",
            .conducted_poc_demo => "Conducted POC / Demo",
            .in_evaluation_planning_stage => "In evaluation / planning stage",
            .agreed_on_solution_to_business_problem => "Agreed on solution to Business Problem",
            .completed_action_plan => "Completed Action Plan",
            .finalized_deployment_needs => "Finalized Deployment Need",
            .sow_signed => "SOW Signed",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
