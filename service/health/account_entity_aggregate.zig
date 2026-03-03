const aws = @import("aws");

/// The number of entities in an account that are impacted by a specific event
/// aggregated by the entity status codes.
pub const AccountEntityAggregate = struct {
    /// The 12-digit Amazon Web Services account numbers that contains the affected
    /// entities.
    account_id: ?[]const u8 = null,

    /// The number of entities that match the filter criteria for the specified
    /// events.
    count: i32 = 0,

    /// The number of affected entities aggregated by the entity status codes.
    statuses: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .count = "count",
        .statuses = "statuses",
    };
};
