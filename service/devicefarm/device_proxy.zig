/// Represents the http/s proxy configuration that will be applied to a device
/// during a run.
pub const DeviceProxy = struct {
    /// Hostname or IPv4 address of the proxy.
    host: []const u8,

    /// The port number on which the http/s proxy is listening.
    port: i32 = 3128,

    pub const json_field_names = .{
        .host = "host",
        .port = "port",
    };
};
