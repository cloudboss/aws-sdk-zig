const Distribution = @import("distribution.zig").Distribution;

/// The distribution of traffic between the instance and its replicas.
pub const TelephonyConfig = struct {
    /// Information about traffic distributions.
    distributions: []const Distribution,

    pub const json_field_names = .{
        .distributions = "Distributions",
    };
};
