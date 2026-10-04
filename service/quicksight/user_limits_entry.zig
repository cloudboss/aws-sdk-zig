/// Identifies a user for the `BatchDescribeUserLimits` operation.
pub const UserLimitsEntry = struct {
    /// The namespace of the user.
    namespace: []const u8,

    /// The name of the user.
    user_name: []const u8,

    pub const json_field_names = .{
        .namespace = "namespace",
        .user_name = "userName",
    };
};
