pub const ListRulesRequest = struct {
    /// The name or ARN of the event bus to list the rules for. If you omit this,
    /// the default
    /// event bus is used.
    event_bus_name: ?[]const u8 = null,

    /// The maximum number of results to return.
    limit: ?i32 = null,

    /// The prefix matching the rule name.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call, which you can use to retrieve the
    /// next set of results.
    ///
    /// The value of `nextToken` is a unique pagination token for each page. To
    /// retrieve the next page of results, make the call again using
    /// the returned token. Keep all other arguments unchanged.
    ///
    /// Using an expired pagination token results in an `HTTP 400 InvalidToken`
    /// error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_bus_name = "EventBusName",
        .limit = "Limit",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
    };
};
