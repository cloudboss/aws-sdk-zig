const HypervisorState = @import("hypervisor_state.zig").HypervisorState;

/// Represents the hypervisor's permissions to which the gateway will connect.
///
/// A hypervisor is hardware, software, or firmware that creates and manages
/// virtual machines,
/// and allocates resources to them.
pub const Hypervisor = struct {
    /// The server host of the hypervisor. This can be either an IP address or a
    /// fully-qualified
    /// domain name (FQDN).
    host: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hypervisor.
    hypervisor_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Key Management Service used to encrypt
    /// the
    /// hypervisor.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the hypervisor.
    name: ?[]const u8 = null,

    /// The state of the hypervisor.
    state: ?HypervisorState = null,

    pub const json_field_names = .{
        .host = "Host",
        .hypervisor_arn = "HypervisorArn",
        .kms_key_arn = "KmsKeyArn",
        .name = "Name",
        .state = "State",
    };
};
