const SecurityPolicyProtocol = @import("security_policy_protocol.zig").SecurityPolicyProtocol;
const SecurityPolicyResourceType = @import("security_policy_resource_type.zig").SecurityPolicyResourceType;

/// Describes the properties of a security policy that you specify. For more
/// information about security policies, see [Working with security policies for
/// servers](https://docs.aws.amazon.com/transfer/latest/userguide/security-policies.html) or [Working with security policies for SFTP connectors](https://docs.aws.amazon.com/transfer/latest/userguide/security-policies-connectors.html).
pub const DescribedSecurityPolicy = struct {
    /// Specifies whether this policy enables Federal Information Processing
    /// Standards (FIPS). This parameter applies to both server and connector
    /// security policies.
    fips: ?bool,

    /// Lists the file transfer protocols that the security policy applies to.
    protocols: ?[]const SecurityPolicyProtocol,

    /// The text name of the specified security policy.
    security_policy_name: []const u8,

    /// Lists the enabled Secure Shell (SSH) cipher encryption algorithms in the
    /// security policy that is attached to the server or connector. This parameter
    /// applies to both server and connector security policies.
    ssh_ciphers: ?[]const []const u8,

    /// Lists the host key algorithms for the security policy.
    ///
    /// This parameter only applies to security policies for connectors.
    ssh_host_key_algorithms: ?[]const []const u8,

    /// Lists the enabled SSH key exchange (KEX) encryption algorithms in the
    /// security policy that is attached to the server or connector. This parameter
    /// applies to both server and connector security policies.
    ssh_kexs: ?[]const []const u8,

    /// Lists the enabled SSH message authentication code (MAC) encryption
    /// algorithms in the security policy that is attached to the server or
    /// connector. This parameter applies to both server and connector security
    /// policies.
    ssh_macs: ?[]const []const u8,

    /// Lists the enabled Transport Layer Security (TLS) cipher encryption
    /// algorithms in the security policy that is attached to the server.
    ///
    /// This parameter only applies to security policies for servers.
    tls_ciphers: ?[]const []const u8,

    /// The resource type to which the security policy applies, either server or
    /// connector.
    type: ?SecurityPolicyResourceType,

    pub const json_field_names = .{
        .fips = "Fips",
        .protocols = "Protocols",
        .security_policy_name = "SecurityPolicyName",
        .ssh_ciphers = "SshCiphers",
        .ssh_host_key_algorithms = "SshHostKeyAlgorithms",
        .ssh_kexs = "SshKexs",
        .ssh_macs = "SshMacs",
        .tls_ciphers = "TlsCiphers",
        .type = "Type",
    };
};
