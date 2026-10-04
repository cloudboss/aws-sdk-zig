const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeRange = @import("time_range.zig").TimeRange;
const Engagement = @import("engagement.zig").Engagement;

pub const ListEngagementsInput = struct {
    /// The Amazon Resource Name (ARN) of the incident you're listing engagements
    /// for.
    incident_id: ?[]const u8 = null,

    /// The maximum number of engagements per page of results.
    max_results: ?i32 = null,

    /// The pagination token to continue to the next page of results.
    next_token: ?[]const u8 = null,

    /// The time range to lists engagements for an incident.
    time_range_value: ?TimeRange = null,

    pub const json_field_names = .{
        .incident_id = "IncidentId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .time_range_value = "TimeRangeValue",
    };
};

pub const ListEngagementsOutput = struct {
    /// A list of each engagement that occurred during the specified time range of
    /// an
    /// incident.
    engagements: ?[]const Engagement = null,

    /// The pagination token to continue to the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engagements = "Engagements",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementsInput, options: CallOptions) !ListEngagementsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.ListEngagements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEngagementsOutput, body, allocator);
}
