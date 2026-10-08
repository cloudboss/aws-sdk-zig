const NewRelicRegion = @import("new_relic_region.zig").NewRelicRegion;

/// Details specific to a registered NewRelic instance.
pub const RegisteredNewRelicDetails = struct {
    /// The NewRelic account ID.
    account_id: []const u8,

    /// Optional user description.
    description: ?[]const u8 = null,

    /// The NewRelic region (determines API endpoint).
    region: NewRelicRegion,

    pub const json_field_names = .{
        .account_id = "accountId",
        .description = "description",
        .region = "region",
    };
};
