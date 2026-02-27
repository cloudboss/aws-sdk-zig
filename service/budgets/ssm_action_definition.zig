const ActionSubType = @import("action_sub_type.zig").ActionSubType;

/// The Amazon Web Services Systems Manager (SSM) action definition details.
pub const SsmActionDefinition = struct {
    /// The action subType.
    action_sub_type: ActionSubType,

    /// The EC2 and RDS instance IDs.
    instance_ids: []const []const u8,

    /// The Region to run the SSM document.
    region: []const u8,

    pub const json_field_names = .{
        .action_sub_type = "ActionSubType",
        .instance_ids = "InstanceIds",
        .region = "Region",
    };
};
