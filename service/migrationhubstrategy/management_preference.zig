const AwsManagedResources = @import("aws_managed_resources.zig").AwsManagedResources;
const NoManagementPreference = @import("no_management_preference.zig").NoManagementPreference;
const SelfManageResources = @import("self_manage_resources.zig").SelfManageResources;

/// Preferences for migrating an application to AWS.
pub const ManagementPreference = union(enum) {
    /// Indicates interest in solutions that are managed by AWS.
    aws_managed_resources: ?AwsManagedResources,
    /// No specific preference.
    no_preference: ?NoManagementPreference,
    /// Indicates interest in managing your own resources on AWS.
    self_manage_resources: ?SelfManageResources,

    pub const json_field_names = .{
        .aws_managed_resources = "awsManagedResources",
        .no_preference = "noPreference",
        .self_manage_resources = "selfManageResources",
    };
};
