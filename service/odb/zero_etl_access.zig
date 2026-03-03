const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The configuration for Zero-ETL access from the ODB network.
pub const ZeroEtlAccess = struct {
    /// The CIDR block for the Zero-ETL access.
    cidr: ?[]const u8 = null,

    /// The status of the Zero-ETL access.
    status: ?ManagedResourceStatus = null,

    pub const json_field_names = .{
        .cidr = "cidr",
        .status = "status",
    };
};
