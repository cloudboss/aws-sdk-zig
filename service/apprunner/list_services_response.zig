const ServiceSummary = @import("service_summary.zig").ServiceSummary;

pub const ListServicesResponse = struct {
    /// The token that you can pass in a subsequent request to get the next result
    /// page. It's returned in a paginated request.
    next_token: ?[]const u8,

    /// A list of service summary information records. In a paginated request, the
    /// request returns up to `MaxResults` records for each call.
    service_summary_list: []const ServiceSummary,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .service_summary_list = "ServiceSummaryList",
    };
};
