const GovernedAction = @import("governed_action.zig").GovernedAction;
const ApplicableTo = @import("applicable_to.zig").ApplicableTo;
const AssetType = @import("asset_type.zig").AssetType;

/// A governance approval policy that specifies which principals and governed
/// actions require
/// approval, and which assets the policy applies to.
pub const ApprovalPolicy = struct {
    /// The list of governed actions that trigger the approval workflow.
    actions: []const GovernedAction,

    /// The scoping configuration that determines who the approval policy applies
    /// to.
    applicable_to: ApplicableTo,

    /// The list of group ARNs whose members can approve requests.
    approval_groups: []const []const u8,

    /// The list of asset types that the approval policy applies to.
    asset_types: []const AssetType,

    /// The date and time that the approval policy was created.
    created_at: i64,

    /// A description of the approval policy.
    description: ?[]const u8 = null,

    /// The name of the approval policy.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the approval policy.
    policy_arn: []const u8,

    /// The unique identifier of the approval policy.
    policy_id: []const u8,

    /// The date and time that the approval policy was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .actions = "Actions",
        .applicable_to = "ApplicableTo",
        .approval_groups = "ApprovalGroups",
        .asset_types = "AssetTypes",
        .created_at = "CreatedAt",
        .description = "Description",
        .name = "Name",
        .policy_arn = "PolicyArn",
        .policy_id = "PolicyId",
        .updated_at = "UpdatedAt",
    };
};
