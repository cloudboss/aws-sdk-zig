const CapacityBytesRangeFilter = @import("capacity_bytes_range_filter.zig").CapacityBytesRangeFilter;
const UserNameOrEmailFilter = @import("user_name_or_email_filter.zig").UserNameOrEmailFilter;

/// A filter for user index capacity queries. Only one filter type can be
/// specified per request.
pub const UserIndexCapacityFilter = union(enum) {
    /// Filter users by total capacity range in bytes.
    total_capacity_bytes: ?CapacityBytesRangeFilter,
    /// Filter users by username or email prefix.
    user_name_or_email: ?UserNameOrEmailFilter,

    pub const json_field_names = .{
        .total_capacity_bytes = "totalCapacityBytes",
        .user_name_or_email = "userNameOrEmail",
    };
};
