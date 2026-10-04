const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationEventStatus = @import("configuration_event_status.zig").ConfigurationEventStatus;
const ConfigurationEvent = @import("configuration_event.zig").ConfigurationEvent;

pub const ListConfigurationHistoryInput = struct {
    /// The Amazon Web Services account ID for the resource group owner.
    account_id: ?[]const u8 = null,

    /// The end time of the event.
    end_time: ?i64 = null,

    /// The status of the configuration update event. Possible values include INFO,
    /// WARN, and
    /// ERROR.
    event_status: ?ConfigurationEventStatus = null,

    /// The maximum number of results returned by `ListConfigurationHistory` in
    /// paginated output. When this parameter is used, `ListConfigurationHistory`
    /// returns only `MaxResults` in a single page along with a `NextToken`
    /// response element. The remaining results of the initial request can be seen
    /// by sending
    /// another `ListConfigurationHistory` request with the returned
    /// `NextToken` value. If this parameter is not used, then
    /// `ListConfigurationHistory` returns all results.
    max_results: ?i32 = null,

    /// The `NextToken` value returned from a previous paginated
    /// `ListConfigurationHistory` request where `MaxResults` was used and
    /// the results exceeded the value of that parameter. Pagination continues from
    /// the end of the
    /// previous results that returned the `NextToken` value. This value is
    /// `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Resource group to which the application belongs.
    resource_group_name: ?[]const u8 = null,

    /// The start time of the event.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .end_time = "EndTime",
        .event_status = "EventStatus",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_group_name = "ResourceGroupName",
        .start_time = "StartTime",
    };
};

pub const ListConfigurationHistoryOutput = struct {
    /// The list of configuration events and their corresponding details.
    event_list: ?[]const ConfigurationEvent = null,

    /// The `NextToken` value to include in a future
    /// `ListConfigurationHistory` request. When the results of a
    /// `ListConfigurationHistory` request exceed `MaxResults`, this value
    /// can be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_list = "EventList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationHistoryInput, options: CallOptions) !ListConfigurationHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "applicationinsights", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationinsights", "Application Insights", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.ListConfigurationHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListConfigurationHistoryOutput, body, allocator);
}
