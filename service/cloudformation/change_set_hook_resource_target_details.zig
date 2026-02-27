const ChangeAction = @import("change_action.zig").ChangeAction;

/// Specifies `RESOURCE` type target details for activated Hooks.
pub const ChangeSetHookResourceTargetDetails = struct {
    /// The resource's logical ID, which is defined in the stack's template.
    logical_resource_id: ?[]const u8,

    /// Specifies the action of the resource.
    resource_action: ?ChangeAction,

    /// The type of CloudFormation resource, such as `AWS::S3::Bucket`.
    resource_type: ?[]const u8,
};
