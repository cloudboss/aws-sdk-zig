const SignInDistribution = @import("sign_in_distribution.zig").SignInDistribution;

/// The distribution that determines which Amazon Web Services Regions should be
/// used to sign in agents in to both
/// the instance and its replica(s).
pub const SignInConfig = struct {
    /// Information about traffic distributions.
    distributions: []const SignInDistribution,

    pub const json_field_names = .{
        .distributions = "Distributions",
    };
};
