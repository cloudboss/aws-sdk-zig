const BusinessGoals = @import("business_goals.zig").BusinessGoals;

/// Rank of business goals based on priority.
pub const PrioritizeBusinessGoals = struct {
    /// Rank of business goals based on priority.
    business_goals: ?BusinessGoals,

    pub const json_field_names = .{
        .business_goals = "businessGoals",
    };
};
