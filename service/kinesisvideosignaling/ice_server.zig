/// A structure for the ICE server connection data.
pub const IceServer = struct {
    /// A password to login to the ICE server.
    password: ?[]const u8,

    /// The period of time, in seconds, during which the username and password are
    /// valid.
    ttl: ?i32,

    /// An array of URIs, in the form specified in the
    /// [I-D.petithuguenin-behave-turn-uris](https://tools.ietf.org/html/draft-petithuguenin-behave-turn-uris-03) spec. These URIs provide the different
    /// addresses and/or protocols that can be used to reach the TURN server.
    uris: ?[]const []const u8,

    /// A username to login to the ICE server.
    username: ?[]const u8,

    pub const json_field_names = .{
        .password = "Password",
        .ttl = "Ttl",
        .uris = "Uris",
        .username = "Username",
    };
};
