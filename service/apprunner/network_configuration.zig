const EgressConfiguration = @import("egress_configuration.zig").EgressConfiguration;
const IngressConfiguration = @import("ingress_configuration.zig").IngressConfiguration;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;

/// Describes configuration settings related to network traffic of an App Runner
/// service. Consists of embedded objects for each configurable network
/// feature.
pub const NetworkConfiguration = struct {
    /// Network configuration settings for outbound message traffic.
    egress_configuration: ?EgressConfiguration,

    /// Network configuration settings for inbound message traffic.
    ingress_configuration: ?IngressConfiguration,

    /// App Runner provides you with the option to choose between *IPv4* and *dual
    /// stack* (IPv4 and IPv6).
    /// This is an optional parameter. If you do not specify an `IpAddressType`, it
    /// defaults to select IPv4.
    ip_address_type: ?IpAddressType,

    pub const json_field_names = .{
        .egress_configuration = "EgressConfiguration",
        .ingress_configuration = "IngressConfiguration",
        .ip_address_type = "IpAddressType",
    };
};
