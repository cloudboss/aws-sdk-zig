const HeaderMatchMethod = @import("header_match_method.zig").HeaderMatchMethod;

/// An object that represents the HTTP header in the gateway route.
pub const HttpGatewayRouteHeader = struct {
    /// Specify `True` to match anything except the match criteria. The default
    /// value
    /// is `False`.
    invert: ?bool,

    /// An object that represents the method and value to match with the header
    /// value sent in a
    /// request. Specify one match method.
    match: ?HeaderMatchMethod,

    /// A name for the HTTP header in the gateway route that will be matched on.
    name: []const u8,

    pub const json_field_names = .{
        .invert = "invert",
        .match = "match",
        .name = "name",
    };
};
