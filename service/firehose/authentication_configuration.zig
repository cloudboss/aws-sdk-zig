const Connectivity = @import("connectivity.zig").Connectivity;

/// The authentication configuration of the Amazon MSK cluster.
pub const AuthenticationConfiguration = struct {
    /// The type of connectivity used to access the Amazon MSK cluster.
    connectivity: Connectivity,

    /// The ARN of the role used to access the Amazon MSK cluster.
    role_arn: []const u8,

    pub const json_field_names = .{
        .connectivity = "Connectivity",
        .role_arn = "RoleARN",
    };
};
