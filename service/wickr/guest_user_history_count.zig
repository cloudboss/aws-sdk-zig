/// Contains the count of guest users for a specific billing period, used for
/// tracking historical guest user activity.
pub const GuestUserHistoryCount = struct {
    /// The number of guest users who have communicated with your Wickr network
    /// during this billing period.
    count: []const u8,

    /// The month and billing period in YYYY_MM format (e.g., '2024_01').
    month: []const u8,

    pub const json_field_names = .{
        .count = "count",
        .month = "month",
    };
};
