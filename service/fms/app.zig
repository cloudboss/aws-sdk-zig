/// An individual Firewall Manager application.
pub const App = struct {
    /// The application's name.
    app_name: []const u8,

    /// The application's port number, for example `80`.
    port: i64,

    /// The IP protocol name or number. The name can be one of `tcp`, `udp`, or
    /// `icmp`. For information on possible numbers, see [Protocol
    /// Numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    protocol: []const u8,

    pub const json_field_names = .{
        .app_name = "AppName",
        .port = "Port",
        .protocol = "Protocol",
    };
};
