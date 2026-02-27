const ContactFlowModuleState = @import("contact_flow_module_state.zig").ContactFlowModuleState;
const ContactFlowModuleStatus = @import("contact_flow_module_status.zig").ContactFlowModuleStatus;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return flow modules.
pub const ContactFlowModuleSearchCriteria = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_conditions: ?[]const ContactFlowModuleSearchCriteria,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const ContactFlowModuleSearchCriteria,

    /// The state of the flow.
    state_condition: ?ContactFlowModuleState,

    /// The status of the flow.
    status_condition: ?ContactFlowModuleStatus,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .state_condition = "StateCondition",
        .status_condition = "StatusCondition",
        .string_condition = "StringCondition",
    };
};
