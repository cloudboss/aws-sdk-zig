const aws = @import("aws");

const RoleGroupAssignment = @import("role_group_assignment.zig").RoleGroupAssignment;

/// Configuration settings for the SageMaker Partner AI App.
pub const PartnerAppConfig = struct {
    /// The list of users that are given admin access to the SageMaker Partner AI
    /// App.
    admin_users: ?[]const []const u8 = null,

    /// This is a map of required inputs for a SageMaker Partner AI App. Based on
    /// the application type, the map is populated with a key and value pair that is
    /// specific to the user and application.
    arguments: ?[]const aws.map.StringMapEntry = null,

    /// A list of Amazon Web Services IAM Identity Center group patterns that can
    /// access the SageMaker Partner AI App. Group names support wildcard matching
    /// using `*`. An empty list indicates the app will not use Identity Center
    /// group features. All groups specified in `RoleGroupAssignments` must match
    /// patterns in this list.
    assigned_group_patterns: ?[]const []const u8 = null,

    /// A map of in-app roles to Amazon Web Services IAM Identity Center group
    /// patterns. Groups assigned to specific roles receive those permissions, while
    /// groups in `AssignedGroupPatterns` but not in this map receive default in-app
    /// role depending on app type. Group patterns support wildcard matching using
    /// `*`. Currently supported by Fiddler version 1.3 and later with roles:
    /// `ORG_MEMBER` (default) and `ORG_ADMIN`.
    role_group_assignments: ?[]const RoleGroupAssignment = null,

    pub const json_field_names = .{
        .admin_users = "AdminUsers",
        .arguments = "Arguments",
        .assigned_group_patterns = "AssignedGroupPatterns",
        .role_group_assignments = "RoleGroupAssignments",
    };
};
