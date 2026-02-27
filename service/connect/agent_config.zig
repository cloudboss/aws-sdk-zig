const Distribution = @import("distribution.zig").Distribution;

/// The distribution of agents between the instance and its replica(s).
pub const AgentConfig = struct {
    /// Information about traffic distributions.
    distributions: []const Distribution,

    pub const json_field_names = .{
        .distributions = "Distributions",
    };
};
