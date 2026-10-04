const CapacityProviderStatus = @import("capacity_provider_status.zig").CapacityProviderStatus;

/// A summary of a capacity provider, as returned by `ListCapacityProviders`.
/// Each summary includes the capacity provider identifier, Amazon Resource Name
/// (ARN), name, status, and last-updated timestamp.
pub const CapacityProviderSummary = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The unique identifier of the capacity provider.
    capacity_provider_id: []const u8,

    /// The timestamp when the capacity provider was last updated.
    last_updated_at: i64,

    /// The name of the capacity provider.
    name: []const u8,

    /// The current status of the capacity provider. For possible values, see
    /// `CapacityProviderStatus`.
    status: CapacityProviderStatus,

    pub const json_field_names = .{
        .capacity_provider_arn = "capacityProviderArn",
        .capacity_provider_id = "capacityProviderId",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};
