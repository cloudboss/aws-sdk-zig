/// Describes the weight of a target group.
pub const WeightedTargetGroup = struct {
    /// The ID or ARN of the target group.
    target_group_identifier: []const u8,

    /// Only required if you specify multiple target groups for a forward action.
    /// The weight determines how requests are distributed to the target group. For
    /// example, if you specify two target groups, each with a weight of 10, each
    /// target group receives half the requests. If you specify two target groups,
    /// one with a weight of 10 and the other with a weight of 20, the target group
    /// with a weight of 20 receives twice as many requests as the other target
    /// group. If there's only one target group specified, then the default value is
    /// 100.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .target_group_identifier = "targetGroupIdentifier",
        .weight = "weight",
    };
};
