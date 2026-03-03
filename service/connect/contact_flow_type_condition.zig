const ContactFlowType = @import("contact_flow_type.zig").ContactFlowType;

/// The contact flow type condition.
pub const ContactFlowTypeCondition = struct {
    /// Contact flow type of the contact flow type condition.
    contact_flow_type: ?ContactFlowType = null,

    pub const json_field_names = .{
        .contact_flow_type = "ContactFlowType",
    };
};
