const LimitEntry = @import("limit_entry.zig").LimitEntry;
const GatewayRateLimitStatus = @import("gateway_rate_limit_status.zig").GatewayRateLimitStatus;

/// Contains detailed information about a gateway rate limit, including its
/// configuration and current status.
pub const GatewayRateLimitDetail = struct {
    /// The timestamp when the rate limit was created.
    created_at: i64,

    /// The human-readable description of the rate limit.
    description: ?[]const u8 = null,

    /// The ordered list of dimension key names that define the scope of this rate
    /// limit.
    dimension_keys: []const []const u8,

    /// The list of rule entries that map dimension values to rate configurations.
    entries: []const LimitEntry,

    /// The unique identifier of the gateway.
    gateway_identifier: []const u8,

    /// The unique identifier of the rate limit.
    rate_limit_id: []const u8,

    /// The current status of the rate limit.
    status: GatewayRateLimitStatus,

    /// The timestamp when the rate limit was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .dimension_keys = "dimensionKeys",
        .entries = "entries",
        .gateway_identifier = "gatewayIdentifier",
        .rate_limit_id = "rateLimitId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
