/// Details specific to a registered PagerDuty service.
pub const RegisteredPagerDutyDetails = struct {
    /// The scopes that were assigned to the service
    scopes: []const []const u8,

    pub const json_field_names = .{
        .scopes = "scopes",
    };
};
