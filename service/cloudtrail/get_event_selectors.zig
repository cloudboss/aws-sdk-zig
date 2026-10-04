const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const EventSelector = @import("event_selector.zig").EventSelector;

pub const GetEventSelectorsInput = struct {
    /// Specifies the name of the trail or trail ARN. If you specify a trail name,
    /// the string
    /// must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.),
    ///   underscores
    /// (_), or dashes (-)
    ///
    /// * Start with a letter or number, and end with a letter or number
    ///
    /// * Be between 3 and 128 characters
    ///
    /// * Have no adjacent periods, underscores or dashes. Names like
    /// `my-_namespace` and `my--namespace` are not valid.
    ///
    /// * Not be in IP address format (for example, 192.168.5.4)
    ///
    /// If you specify a trail ARN, it must be in the format:
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    trail_name: []const u8,

    pub const json_field_names = .{
        .trail_name = "TrailName",
    };
};

pub const GetEventSelectorsOutput = struct {
    /// The advanced event selectors that are configured for the trail.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// The event selectors that are configured for the trail.
    event_selectors: ?[]const EventSelector = null,

    /// The specified trail ARN that has the event selectors.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .event_selectors = "EventSelectors",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventSelectorsInput, options: CallOptions) !GetEventSelectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventSelectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GetEventSelectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventSelectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEventSelectorsOutput, body, allocator);
}
