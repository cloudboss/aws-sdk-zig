const HeaderMatchMethod = @import("header_match_method.zig").HeaderMatchMethod;

/// An object that represents the HTTP header in the request.
pub const HttpRouteHeader = struct {
    /// Specify `True` to match anything except the match criteria. The default
    /// value is `False`.
    invert: ?bool = null,

    /// The `HeaderMatchMethod` object.
    match: ?HeaderMatchMethod = null,

    /// A name for the HTTP header in the client request that will be matched on.
    name: []const u8,

    pub const json_field_names = .{
        .invert = "invert",
        .match = "match",
        .name = "name",
    };
};
