const ContactFlowState = @import("contact_flow_state.zig").ContactFlowState;
const ContactFlowStatus = @import("contact_flow_status.zig").ContactFlowStatus;
const ContactFlowType = @import("contact_flow_type.zig").ContactFlowType;

/// Contains summary information about a flow.
///
/// You can also create and update flows using the [Amazon Connect
/// Flow
/// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language.html).
pub const ContactFlowSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: ?[]const u8 = null,

    /// The type of flow.
    contact_flow_state: ?ContactFlowState = null,

    /// The status of the flow.
    contact_flow_status: ?ContactFlowStatus = null,

    /// The type of flow.
    contact_flow_type: ?ContactFlowType = null,

    /// The identifier of the flow.
    id: ?[]const u8 = null,

    /// The name of the flow.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .contact_flow_state = "ContactFlowState",
        .contact_flow_status = "ContactFlowStatus",
        .contact_flow_type = "ContactFlowType",
        .id = "Id",
        .name = "Name",
    };
};
