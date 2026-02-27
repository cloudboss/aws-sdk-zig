const NetworkType = @import("network_type.zig").NetworkType;
const RadiusSettings = @import("radius_settings.zig").RadiusSettings;
const RadiusStatus = @import("radius_status.zig").RadiusStatus;
const DirectoryVpcSettingsDescription = @import("directory_vpc_settings_description.zig").DirectoryVpcSettingsDescription;

/// Contains the directory owner account details shared with the directory
/// consumer
/// account.
pub const OwnerDirectoryDescription = struct {
    /// Identifier of the directory owner account.
    account_id: ?[]const u8,

    /// Identifier of the Managed Microsoft AD directory in the directory owner
    /// account.
    directory_id: ?[]const u8,

    /// IP address of the directory’s domain controllers.
    dns_ip_addrs: ?[]const []const u8,

    /// IPv6 addresses of the directory’s domain controllers.
    dns_ipv_6_addrs: ?[]const []const u8,

    /// Network type of the directory in the directory owner account.
    network_type: ?NetworkType,

    /// Information about the RadiusSettings object server configuration.
    radius_settings: ?RadiusSettings,

    /// The status of the RADIUS server.
    radius_status: ?RadiusStatus,

    /// Information about the VPC settings for the directory.
    vpc_settings: ?DirectoryVpcSettingsDescription,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .directory_id = "DirectoryId",
        .dns_ip_addrs = "DnsIpAddrs",
        .dns_ipv_6_addrs = "DnsIpv6Addrs",
        .network_type = "NetworkType",
        .radius_settings = "RadiusSettings",
        .radius_status = "RadiusStatus",
        .vpc_settings = "VpcSettings",
    };
};
