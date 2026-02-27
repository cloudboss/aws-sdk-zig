/// Represents the information required for client programs to connect to the
/// endpoint
/// for a DAX cluster.
pub const Endpoint = struct {
    /// The DNS hostname of the endpoint.
    address: ?[]const u8,

    /// The port number that applications should use to connect to the endpoint.
    port: i32 = 0,

    /// The URL that applications should use to connect to the endpoint. The default
    /// ports
    /// are 8111 for the "dax" protocol and 9111 for the "daxs" protocol.
    url: ?[]const u8,

    pub const json_field_names = .{
        .address = "Address",
        .port = "Port",
        .url = "URL",
    };
};
