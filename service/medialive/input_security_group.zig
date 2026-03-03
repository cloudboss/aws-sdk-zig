const aws = @import("aws");

const InputSecurityGroupState = @import("input_security_group_state.zig").InputSecurityGroupState;
const InputWhitelistRule = @import("input_whitelist_rule.zig").InputWhitelistRule;

/// An Input Security Group
pub const InputSecurityGroup = struct {
    /// Unique ARN of Input Security Group
    arn: ?[]const u8 = null,

    /// The list of channels currently using this Input Security Group as their
    /// channel security group.
    channels: ?[]const []const u8 = null,

    /// The Id of the Input Security Group
    id: ?[]const u8 = null,

    /// The list of inputs currently using this Input Security Group.
    inputs: ?[]const []const u8 = null,

    /// The current state of the Input Security Group.
    state: ?InputSecurityGroupState = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Whitelist rules and their sync status
    whitelist_rules: ?[]const InputWhitelistRule = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channels = "Channels",
        .id = "Id",
        .inputs = "Inputs",
        .state = "State",
        .tags = "Tags",
        .whitelist_rules = "WhitelistRules",
    };
};
