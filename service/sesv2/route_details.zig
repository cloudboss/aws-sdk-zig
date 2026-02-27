/// An object that contains route configuration. Includes secondary region name.
pub const RouteDetails = struct {
    /// The name of an AWS-Region to be a secondary region for the multi-region
    /// endpoint (global-endpoint).
    region: []const u8,

    pub const json_field_names = .{
        .region = "Region",
    };
};
