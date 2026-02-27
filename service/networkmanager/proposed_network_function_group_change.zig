const Tag = @import("tag.zig").Tag;

/// Describes proposed changes to a network function group.
pub const ProposedNetworkFunctionGroupChange = struct {
    /// The proposed new attachment policy rule number for the network function
    /// group.
    attachment_policy_rule_number: ?i32,

    /// The proposed name change for the network function group name.
    network_function_group_name: ?[]const u8,

    /// The list of proposed changes to the key-value tags associated with the
    /// network function group.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .attachment_policy_rule_number = "AttachmentPolicyRuleNumber",
        .network_function_group_name = "NetworkFunctionGroupName",
        .tags = "Tags",
    };
};
