const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventCategory = @import("event_category.zig").EventCategory;
const LookupAttribute = @import("lookup_attribute.zig").LookupAttribute;
const Event = @import("event.zig").Event;

pub const LookupEventsInput = struct {
    /// Specifies that only events that occur before or at the specified time are
    /// returned. If
    /// the specified end time is before the specified start time, an error is
    /// returned.
    end_time: ?i64 = null,

    /// Specifies the event category. If you do not specify an event category,
    /// events of the
    /// category are not returned in the response. For example, if you do not
    /// specify
    /// `insight` as the value of `EventCategory`, no Insights events are
    /// returned.
    event_category: ?EventCategory = null,

    /// Contains a list of lookup attributes. Currently the list can contain only
    /// one
    /// item.
    lookup_attributes: ?[]const LookupAttribute = null,

    /// The number of events to return. Possible values are 1 through 50. The
    /// default is
    /// 50.
    max_results: ?i32 = null,

    /// The token to use to get the next page of results after a previous API call.
    /// This token
    /// must be passed in with the same parameters that were specified in the
    /// original call. For
    /// example, if the original call specified an AttributeKey of 'Username' with a
    /// value of
    /// 'root', the call with NextToken should include those same parameters.
    next_token: ?[]const u8 = null,

    /// Specifies that only events that occur after or at the specified time are
    /// returned. If
    /// the specified start time is after the specified end time, an error is
    /// returned.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .event_category = "EventCategory",
        .lookup_attributes = "LookupAttributes",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const LookupEventsOutput = struct {
    /// A list of events returned based on the lookup attributes specified and the
    /// CloudTrail event. The events list is sorted by time. The most recent event
    /// is listed
    /// first.
    events: ?[]const Event = null,

    /// The token to use to get the next page of results after a previous API call.
    /// If the token
    /// does not appear, there are no more results to return. The token must be
    /// passed in with the
    /// same parameters as the previous call. For example, if the original call
    /// specified an
    /// AttributeKey of 'Username' with a value of 'root', the call with NextToken
    /// should include
    /// those same parameters.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: LookupEventsInput, options: CallOptions) !LookupEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: LookupEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.LookupEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !LookupEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(LookupEventsOutput, body, allocator);
}
