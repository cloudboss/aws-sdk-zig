const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The configuration access for the cross-Region Amazon S3 database restore
/// source for the ODB network.
pub const CrossRegionS3RestoreSourcesAccess = struct {
    /// The IPv4 addresses allowed for cross-Region Amazon S3 restore access.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The Amazon Web Services Region for cross-Region Amazon S3 restore access.
    region: ?[]const u8 = null,

    /// The current status of the cross-Region Amazon S3 restore access
    /// configuration.
    status: ?ManagedResourceStatus = null,

    pub const json_field_names = .{
        .ipv_4_addresses = "ipv4Addresses",
        .region = "region",
        .status = "status",
    };
};
