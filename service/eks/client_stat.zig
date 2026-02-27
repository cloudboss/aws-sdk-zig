/// Details about clients using the deprecated resources.
pub const ClientStat = struct {
    /// The timestamp of the last request seen from the Kubernetes client.
    last_request_time: ?i64,

    /// The number of requests from the Kubernetes client seen over the last 30
    /// days.
    number_of_requests_last_30_days: i32 = 0,

    /// The user agent of the Kubernetes client using the deprecated resource.
    user_agent: ?[]const u8,

    pub const json_field_names = .{
        .last_request_time = "lastRequestTime",
        .number_of_requests_last_30_days = "numberOfRequestsLast30Days",
        .user_agent = "userAgent",
    };
};
