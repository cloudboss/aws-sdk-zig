const UserType = @import("user_type.zig").UserType;

/// Information about a user whose activity is recorded in an event for a space.
pub const UserIdentity = struct {
    /// The Amazon Web Services account number of the user in Amazon Web Services,
    /// if any.
    aws_account_id: ?[]const u8 = null,

    /// The ID of the Amazon CodeCatalyst service principal.
    principal_id: []const u8,

    /// The display name of the user in Amazon CodeCatalyst.
    user_name: ?[]const u8 = null,

    /// The role assigned to the user in a Amazon CodeCatalyst space or project when
    /// the event occurred.
    user_type: UserType,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .principal_id = "principalId",
        .user_name = "userName",
        .user_type = "userType",
    };
};
