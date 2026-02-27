const AttachmentType = @import("attachment_type.zig").AttachmentType;
const AttachmentError = @import("attachment_error.zig").AttachmentError;
const ProposedNetworkFunctionGroupChange = @import("proposed_network_function_group_change.zig").ProposedNetworkFunctionGroupChange;
const ProposedSegmentChange = @import("proposed_segment_change.zig").ProposedSegmentChange;
const AttachmentState = @import("attachment_state.zig").AttachmentState;
const Tag = @import("tag.zig").Tag;

/// Describes a core network attachment.
pub const Attachment = struct {
    /// The ID of the attachment.
    attachment_id: ?[]const u8,

    /// The policy rule number associated with the attachment.
    attachment_policy_rule_number: ?i32,

    /// The type of attachment.
    attachment_type: ?AttachmentType,

    /// The ARN of a core network.
    core_network_arn: ?[]const u8,

    /// The ID of a core network.
    core_network_id: ?[]const u8,

    /// The timestamp when the attachment was created.
    created_at: ?i64,

    /// The Region where the edge is located. This is returned for all attachment
    /// types except a Direct Connect gateway attachment, which instead returns
    /// `EdgeLocations`.
    edge_location: ?[]const u8,

    /// The edge locations that the Direct Connect gateway is associated with. This
    /// is returned only for Direct Connect gateway attachments. All other
    /// attachment types retrun `EdgeLocation`.
    edge_locations: ?[]const []const u8,

    /// Describes the error associated with the attachment request.
    last_modification_errors: ?[]const AttachmentError,

    /// The name of the network function group.
    network_function_group_name: ?[]const u8,

    /// The ID of the attachment account owner.
    owner_account_id: ?[]const u8,

    /// Describes a proposed change to a network function group associated with the
    /// attachment.
    proposed_network_function_group_change: ?ProposedNetworkFunctionGroupChange,

    /// The attachment to move from one segment to another.
    proposed_segment_change: ?ProposedSegmentChange,

    /// The attachment resource ARN.
    resource_arn: ?[]const u8,

    /// The name of the segment attachment.
    segment_name: ?[]const u8,

    /// The state of the attachment.
    state: ?AttachmentState,

    /// The tags associated with the attachment.
    tags: ?[]const Tag,

    /// The timestamp when the attachment was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .attachment_policy_rule_number = "AttachmentPolicyRuleNumber",
        .attachment_type = "AttachmentType",
        .core_network_arn = "CoreNetworkArn",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .edge_location = "EdgeLocation",
        .edge_locations = "EdgeLocations",
        .last_modification_errors = "LastModificationErrors",
        .network_function_group_name = "NetworkFunctionGroupName",
        .owner_account_id = "OwnerAccountId",
        .proposed_network_function_group_change = "ProposedNetworkFunctionGroupChange",
        .proposed_segment_change = "ProposedSegmentChange",
        .resource_arn = "ResourceArn",
        .segment_name = "SegmentName",
        .state = "State",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};
