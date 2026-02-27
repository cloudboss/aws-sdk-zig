const AuthType = @import("auth_type.zig").AuthType;
const OSType = @import("os_type.zig").OSType;

/// IP address based configurations.
pub const IPAddressBasedRemoteInfo = struct {
    /// The type of authorization.
    auth_type: ?AuthType,

    /// The time stamp of the configuration.
    ip_address_configuration_time_stamp: ?[]const u8,

    /// The type of the operating system.
    os_type: ?OSType,

    pub const json_field_names = .{
        .auth_type = "authType",
        .ip_address_configuration_time_stamp = "ipAddressConfigurationTimeStamp",
        .os_type = "osType",
    };
};
