/// The target entity to allocate compute resources to.
pub const ComputeQuotaTarget = struct {
    /// Assigned entity fair-share weight. Idle compute will be shared across
    /// entities based on these assigned weights. This weight is only used when
    /// `FairShare` is enabled.
    ///
    /// A weight of 0 is the lowest priority and 100 is the highest. Weight 0 is the
    /// default.
    fair_share_weight: ?i32 = null,

    /// Name of the team to allocate compute resources to.
    team_name: []const u8,

    pub const json_field_names = .{
        .fair_share_weight = "FairShareWeight",
        .team_name = "TeamName",
    };
};
