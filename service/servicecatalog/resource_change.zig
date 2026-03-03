const ChangeAction = @import("change_action.zig").ChangeAction;
const ResourceChangeDetail = @import("resource_change_detail.zig").ResourceChangeDetail;
const Replacement = @import("replacement.zig").Replacement;
const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;

/// Information about a resource change that will occur when a plan is executed.
pub const ResourceChange = struct {
    /// The change action.
    action: ?ChangeAction = null,

    /// Information about the resource changes.
    details: ?[]const ResourceChangeDetail = null,

    /// The ID of the resource, as defined in the CloudFormation template.
    logical_resource_id: ?[]const u8 = null,

    /// The ID of the resource, if it was already created.
    physical_resource_id: ?[]const u8 = null,

    /// If the change type is `Modify`, indicates whether the existing resource
    /// is deleted and replaced with a new one.
    replacement: ?Replacement = null,

    /// The type of resource.
    resource_type: ?[]const u8 = null,

    /// The change scope.
    scope: ?[]const ResourceAttribute = null,

    pub const json_field_names = .{
        .action = "Action",
        .details = "Details",
        .logical_resource_id = "LogicalResourceId",
        .physical_resource_id = "PhysicalResourceId",
        .replacement = "Replacement",
        .resource_type = "ResourceType",
        .scope = "Scope",
    };
};
