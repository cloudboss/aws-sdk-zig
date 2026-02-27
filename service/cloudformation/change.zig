const ResourceChange = @import("resource_change.zig").ResourceChange;
const ChangeType = @import("change_type.zig").ChangeType;

/// The `Change` structure describes the changes CloudFormation will perform if
/// you
/// execute the change set.
pub const Change = struct {
    /// Is either `null`, if no Hooks invoke for the resource, or contains the
    /// number
    /// of Hooks that will invoke for the resource.
    hook_invocation_count: ?i32,

    /// A `ResourceChange` structure that describes the resource and action that
    /// CloudFormation will perform.
    resource_change: ?ResourceChange,

    /// The type of entity that CloudFormation changes.
    ///
    /// * `Resource` This change is for a resource.
    @"type": ?ChangeType,
};
