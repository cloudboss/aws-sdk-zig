/// An object representing the gateway route host name to match.
pub const GatewayRouteHostnameMatch = struct {
    /// The exact host name to match on.
    exact: ?[]const u8 = null,

    /// The specified ending characters of the host name to match on.
    suffix: ?[]const u8 = null,

    pub const json_field_names = .{
        .exact = "exact",
        .suffix = "suffix",
    };
};
