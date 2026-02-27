/// Represents a guest user who has accessed the network from a federated Wickr
/// network.
pub const GuestUser = struct {
    /// The billing period when this guest user accessed the network (e.g.,
    /// '2024-01').
    billing_period: []const u8,

    /// The username of the guest user.
    username: []const u8,

    /// The unique username hash identifier for the guest user.
    username_hash: []const u8,

    pub const json_field_names = .{
        .billing_period = "billingPeriod",
        .username = "username",
        .username_hash = "usernameHash",
    };
};
