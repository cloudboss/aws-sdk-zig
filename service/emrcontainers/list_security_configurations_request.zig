pub const ListSecurityConfigurationsRequest = struct {
    /// The date and time after which the security configuration was created.
    created_after: ?i64 = null,

    /// The date and time before which the security configuration was created.
    created_before: ?i64 = null,

    /// The maximum number of security configurations the operation can list.
    max_results: ?i32 = null,

    /// The token for the next set of security configurations to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
