/// The primary Region of the endpoint.
pub const Primary = struct {
    /// The ARN of the health check used by the endpoint to determine whether
    /// failover is
    /// triggered.
    health_check: []const u8,

    pub const json_field_names = .{
        .health_check = "HealthCheck",
    };
};
