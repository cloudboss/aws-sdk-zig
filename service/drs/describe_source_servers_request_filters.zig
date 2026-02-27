/// A set of filters by which to return Source Servers.
pub const DescribeSourceServersRequestFilters = struct {
    /// An ID that describes the hardware of the Source Server. This is either an
    /// EC2 instance id, a VMware uuid or a mac address.
    hardware_id: ?[]const u8,

    /// An array of Source Servers IDs that should be returned. An empty array means
    /// all Source Servers.
    source_server_i_ds: ?[]const []const u8,

    /// An array of staging account IDs that extended source servers belong to. An
    /// empty array means all source servers will be shown.
    staging_account_i_ds: ?[]const []const u8,

    pub const json_field_names = .{
        .hardware_id = "hardwareId",
        .source_server_i_ds = "sourceServerIDs",
        .staging_account_i_ds = "stagingAccountIDs",
    };
};
