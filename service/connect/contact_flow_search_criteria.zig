const ContactFlowState = @import("contact_flow_state.zig").ContactFlowState;
const ContactFlowStatus = @import("contact_flow_status.zig").ContactFlowStatus;
const StringCondition = @import("string_condition.zig").StringCondition;
const ContactFlowType = @import("contact_flow_type.zig").ContactFlowType;

/// The search criteria to be used to return flows.
pub const ContactFlowSearchCriteria = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_conditions: ?[]const ContactFlowSearchCriteria,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const ContactFlowSearchCriteria,

    /// The state of the flow.
    state_condition: ?ContactFlowState,

    /// The status of the flow.
    status_condition: ?ContactFlowStatus,

    string_condition: ?StringCondition,

    /// The type of flow.
    type_condition: ?ContactFlowType,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .state_condition = "StateCondition",
        .status_condition = "StatusCondition",
        .string_condition = "StringCondition",
        .type_condition = "TypeCondition",
    };
};
