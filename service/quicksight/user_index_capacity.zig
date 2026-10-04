/// A summary of a user's index capacity consumption.
pub const UserIndexCapacity = struct {
    /// The email address of the user.
    email: ?[]const u8 = null,

    /// The number of knowledge bases owned by the user.
    kb_count: ?i32 = null,

    /// The role of the user.
    role: ?[]const u8 = null,

    /// The number of spaces owned by the user.
    space_count: ?i32 = null,

    /// The total index capacity consumed by the user in bytes.
    total_capacity_bytes: ?i64 = null,

    /// The total index capacity consumed by the user's knowledge bases in bytes.
    total_kb_capacity_bytes: ?i64 = null,

    /// The total index capacity consumed by the user's spaces in bytes.
    total_space_capacity_bytes: ?i64 = null,

    /// The ARN of the user.
    user_arn: ?[]const u8 = null,

    /// The username of the user.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .email = "email",
        .kb_count = "kbCount",
        .role = "role",
        .space_count = "spaceCount",
        .total_capacity_bytes = "totalCapacityBytes",
        .total_kb_capacity_bytes = "totalKBCapacityBytes",
        .total_space_capacity_bytes = "totalSpaceCapacityBytes",
        .user_arn = "userArn",
        .user_name = "userName",
    };
};
