const HostKeyAttributes = @import("host_key_attributes.zig").HostKeyAttributes;
const PasswordData = @import("password_data.zig").PasswordData;
const InstanceAccessProtocol = @import("instance_access_protocol.zig").InstanceAccessProtocol;

/// The parameters for gaining temporary access to one of your Amazon Lightsail
/// instances.
pub const InstanceAccessDetails = struct {
    /// For SSH access, the public key to use when accessing your instance For
    /// OpenSSH clients
    /// (command line SSH), you should save this value to `tempkey-cert.pub`.
    cert_key: ?[]const u8,

    /// For SSH access, the date on which the temporary keys expire.
    expires_at: ?i64,

    /// Describes the public SSH host keys or the RDP certificate.
    host_keys: ?[]const HostKeyAttributes,

    /// The name of this Amazon Lightsail instance.
    instance_name: ?[]const u8,

    /// The public IP address of the Amazon Lightsail instance.
    ip_address: ?[]const u8,

    /// The IPv6 address of the Amazon Lightsail instance.
    ipv_6_addresses: ?[]const []const u8,

    /// For RDP access, the password for your Amazon Lightsail instance. Password
    /// will be an empty
    /// string if the password for your new instance is not ready yet. When you
    /// create an instance, it
    /// can take up to 15 minutes for the instance to be ready.
    ///
    /// If you create an instance using any key pair other than the default
    /// (`LightsailDefaultKeyPair`), `password` will always be an empty
    /// string.
    ///
    /// If you change the Administrator password on the instance, Lightsail will
    /// continue to
    /// return the original password value. When accessing the instance using RDP,
    /// you need to
    /// manually enter the Administrator password after changing it from the
    /// default.
    password: ?[]const u8,

    /// For a Windows Server-based instance, an object with the data you can use to
    /// retrieve your
    /// password. This is only needed if `password` is empty and the instance is not
    /// new
    /// (and therefore the password is not ready yet). When you create an instance,
    /// it can take up to
    /// 15 minutes for the instance to be ready.
    password_data: ?PasswordData,

    /// For SSH access, the temporary private key. For OpenSSH clients (command line
    /// SSH), you
    /// should save this value to `tempkey`).
    private_key: ?[]const u8,

    /// The protocol for these Amazon Lightsail instance access details.
    protocol: ?InstanceAccessProtocol,

    /// The user name to use when logging in to the Amazon Lightsail instance.
    username: ?[]const u8,

    pub const json_field_names = .{
        .cert_key = "certKey",
        .expires_at = "expiresAt",
        .host_keys = "hostKeys",
        .instance_name = "instanceName",
        .ip_address = "ipAddress",
        .ipv_6_addresses = "ipv6Addresses",
        .password = "password",
        .password_data = "passwordData",
        .private_key = "privateKey",
        .protocol = "protocol",
        .username = "username",
    };
};
