/// An object representing the TCP route to match.
pub const TcpRouteMatch = struct {
    /// The port number to match on.
    port: ?i32 = null,

    pub const json_field_names = .{
        .port = "port",
    };
};
