/// Summary information about routing policy associations for an attachment.
pub const AttachmentRoutingPolicyAssociationSummary = struct {
    /// The list of routing policies currently associated with the attachment.
    associated_routing_policies: ?[]const []const u8,

    /// The ID of the attachment associated with the routing policy.
    attachment_id: ?[]const u8,

    /// The list of routing policies that are pending association with the
    /// attachment.
    pending_routing_policies: ?[]const []const u8,

    /// The routing policy label associated with the attachment.
    routing_policy_label: ?[]const u8,

    pub const json_field_names = .{
        .associated_routing_policies = "AssociatedRoutingPolicies",
        .attachment_id = "AttachmentId",
        .pending_routing_policies = "PendingRoutingPolicies",
        .routing_policy_label = "RoutingPolicyLabel",
    };
};
