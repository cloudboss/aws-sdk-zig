/// Contains HTTP route verification details for a target domain, including the
/// route path and token to serve for domain ownership verification.
pub const HttpVerification = struct {
    /// The HTTP route path where the verification token must be served.
    route_path: ?[]const u8 = null,

    /// The verification token to serve at the specified route path.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .route_path = "routePath",
        .token = "token",
    };
};
