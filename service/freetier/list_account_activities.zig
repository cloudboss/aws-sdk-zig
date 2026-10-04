const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActivityStatus = @import("activity_status.zig").ActivityStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;
const ActivitySummary = @import("activity_summary.zig").ActivitySummary;

pub const ListAccountActivitiesInput = struct {
    /// The activity status filter. This field can be used to filter the response by
    /// activities status.
    filter_activity_statuses: ?[]const ActivityStatus = null,

    /// The language code used to return translated titles.
    language_code: ?LanguageCode = null,

    /// The maximum number of items to return for this request. To get the next page
    /// of items, make another request with the token returned in the output.
    max_results: ?i32 = null,

    /// A token from a previous paginated response. If this is specified, the
    /// response includes records beginning from this token (inclusive), up to the
    /// number specified by `maxResults`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_activity_statuses = "filterActivityStatuses",
        .language_code = "languageCode",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAccountActivitiesOutput = struct {
    /// A brief information about the activities.
    activities: ?[]const ActivitySummary = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .activities = "activities",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccountActivitiesInput, options: CallOptions) !ListAccountActivitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsfreetierservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccountActivitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("freetier", "FreeTier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFreeTierService.ListAccountActivities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccountActivitiesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAccountActivitiesOutput, body, allocator);
}
