const ResiliencyGroupType = @import("resiliency_group_type.zig").ResiliencyGroupType;
const ResiliencyGroupState = @import("resiliency_group_state.zig").ResiliencyGroupState;

/// Summary information about a resiliency group.
pub const ResiliencyGroupSummary = struct {
    /// The ID of the Amazon Web Services account that owns the resiliency group.
    owner_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resiliency group.
    resiliency_group_arn: ?[]const u8 = null,

    /// The ID of the resiliency group.
    resiliency_group_id: ?[]const u8 = null,

    /// The name of the resiliency group.
    resiliency_group_name: ?[]const u8 = null,

    /// The type of the resiliency group. The valid value is `Managed`.
    resiliency_group_type: ?ResiliencyGroupType = null,

    /// The state of the resiliency group.
    state: ?ResiliencyGroupState = null,

    pub const json_field_names = .{
        .owner_account = "ownerAccount",
        .resiliency_group_arn = "resiliencyGroupArn",
        .resiliency_group_id = "resiliencyGroupId",
        .resiliency_group_name = "resiliencyGroupName",
        .resiliency_group_type = "resiliencyGroupType",
        .state = "state",
    };
};
