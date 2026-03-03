/// Information about the EC2 Mac Dedicated Host.
pub const MacHost = struct {
    /// The EC2 Mac Dedicated Host ID.
    host_id: ?[]const u8 = null,

    /// The latest macOS versions that the EC2 Mac Dedicated Host can launch without
    /// being upgraded.
    mac_os_latest_supported_versions: ?[]const []const u8 = null,
};
