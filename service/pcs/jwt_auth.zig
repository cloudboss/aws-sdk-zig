const JwtKey = @import("jwt_key.zig").JwtKey;

/// The JWT authentication configuration for Slurm REST API access.
pub const JwtAuth = struct {
    /// The JWT key for Slurm REST API authentication.
    jwt_key: ?JwtKey = null,

    pub const json_field_names = .{
        .jwt_key = "jwtKey",
    };
};
