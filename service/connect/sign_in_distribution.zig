/// The distribution of sign in traffic between the instance and its replica(s).
pub const SignInDistribution = struct {
    /// Whether sign in distribution is enabled.
    enabled: bool = false,

    /// The Amazon Web Services Region of the sign in distribution.
    region: []const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .region = "Region",
    };
};
