const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

/// Information about a firewall rule that was deleted in a batch operation.
pub const BatchDeleteFirewallRuleResult = struct {
    /// The unique string that identified the request and ensured idempotency.
    client_token: ?[]const u8,

    /// The unique identifier of the deleted firewall rule.
    id: []const u8,

    /// The name of the deleted firewall rule.
    name: ?[]const u8,

    /// The final status of the deleted firewall rule.
    status: ?CRResourceStatus,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
