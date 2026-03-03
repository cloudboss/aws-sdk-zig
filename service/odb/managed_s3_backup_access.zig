const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The configuration for managed Amazon S3 backup access from the ODB network.
pub const ManagedS3BackupAccess = struct {
    /// The IPv4 addresses for the managed Amazon S3 backup access.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The status of the managed Amazon S3 backup access.
    status: ?ManagedResourceStatus = null,

    pub const json_field_names = .{
        .ipv_4_addresses = "ipv4Addresses",
        .status = "status",
    };
};
