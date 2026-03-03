/// An object that represents the path to rewrite.
pub const HttpGatewayRoutePathRewrite = struct {
    /// The exact path to rewrite.
    exact: ?[]const u8 = null,

    pub const json_field_names = .{
        .exact = "exact",
    };
};
