const ContactFlowTypeCondition = @import("contact_flow_type_condition.zig").ContactFlowTypeCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// A list of conditions which would be applied together with an AND condition.
pub const ContactFlowAttributeAndCondition = struct {
    /// Contact flow type condition.
    contact_flow_type_condition: ?ContactFlowTypeCondition,

    /// Tag-based conditions for contact flow filtering.
    tag_conditions: ?[]const TagCondition,

    pub const json_field_names = .{
        .contact_flow_type_condition = "ContactFlowTypeCondition",
        .tag_conditions = "TagConditions",
    };
};
