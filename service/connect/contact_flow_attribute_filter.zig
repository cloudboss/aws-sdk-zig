const ContactFlowAttributeAndCondition = @import("contact_flow_attribute_and_condition.zig").ContactFlowAttributeAndCondition;
const ContactFlowTypeCondition = @import("contact_flow_type_condition.zig").ContactFlowTypeCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// Filter for contact flow attributes with multiple condition types.
pub const ContactFlowAttributeFilter = struct {
    /// A list of conditions which would be applied together with a AND condition.
    and_condition: ?ContactFlowAttributeAndCondition = null,

    /// Contact flow type condition within attribute filter.
    contact_flow_type_condition: ?ContactFlowTypeCondition = null,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const ContactFlowAttributeAndCondition = null,

    tag_condition: ?TagCondition = null,

    pub const json_field_names = .{
        .and_condition = "AndCondition",
        .contact_flow_type_condition = "ContactFlowTypeCondition",
        .or_conditions = "OrConditions",
        .tag_condition = "TagCondition",
    };
};
