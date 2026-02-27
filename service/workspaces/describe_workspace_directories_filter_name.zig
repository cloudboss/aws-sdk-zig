pub const DescribeWorkspaceDirectoriesFilterName = enum {
    user_identity_type,
    workspace_type,

    pub const json_field_names = .{
        .user_identity_type = "USER_IDENTITY_TYPE",
        .workspace_type = "WORKSPACE_TYPE",
    };
};
