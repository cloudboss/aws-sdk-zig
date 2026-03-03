const ServerCertificateConfiguration = @import("server_certificate_configuration.zig").ServerCertificateConfiguration;

/// The object that defines a TLS inspection configuration. This, along with
/// TLSInspectionConfigurationResponse, define the TLS inspection configuration.
/// You can retrieve all objects for a TLS inspection configuration by calling
/// DescribeTLSInspectionConfiguration.
///
/// Network Firewall uses a TLS inspection configuration to decrypt traffic.
/// Network Firewall re-encrypts the traffic before sending it to its
/// destination.
///
/// To use a TLS inspection configuration, you add it to a new Network Firewall
/// firewall policy, then you apply the firewall policy to a firewall. Network
/// Firewall acts as a proxy service to decrypt and inspect the traffic
/// traveling through your firewalls. You can reference a TLS inspection
/// configuration from more than one firewall policy, and you can use a firewall
/// policy in more than one firewall. For more information about using TLS
/// inspection configurations, see
/// [Inspecting SSL/TLS traffic with TLS
/// inspection
/// configurations](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tls-inspection.html) in the *Network Firewall Developer Guide*.
pub const TLSInspectionConfiguration = struct {
    /// Lists the server certificate configurations that are associated with the TLS
    /// configuration.
    server_certificate_configurations: ?[]const ServerCertificateConfiguration = null,

    pub const json_field_names = .{
        .server_certificate_configurations = "ServerCertificateConfigurations",
    };
};
