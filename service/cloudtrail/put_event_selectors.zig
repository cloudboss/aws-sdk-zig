const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const EventSelector = @import("event_selector.zig").EventSelector;

pub const PutEventSelectorsInput = struct {
    /// Specifies the settings for advanced event selectors. You can use advanced
    /// event selectors to
    /// log management events, data events for all resource types, and network
    /// activity events.
    ///
    /// You can add advanced event
    /// selectors, and conditions for your advanced event selectors, up to a maximum
    /// of 500 values
    /// for all conditions and selectors on a trail. You can use either
    /// `AdvancedEventSelectors` or `EventSelectors`, but not both. If you
    /// apply `AdvancedEventSelectors` to a trail, any existing
    /// `EventSelectors` are overwritten. For more information about advanced event
    /// selectors, see [Logging data
    /// events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-data-events-with-cloudtrail.html) and
    /// [Logging network activity
    /// events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-network-events-with-cloudtrail.html)
    /// in the *CloudTrail User Guide*.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// Specifies the settings for your event selectors. You can use event selectors
    /// to log management events and data events for the following resource types:
    ///
    /// * `AWS::DynamoDB::Table`
    ///
    /// * `AWS::Lambda::Function`
    ///
    /// * `AWS::S3::Object`
    ///
    /// You can't use event selectors to log network activity events.
    ///
    /// You can configure up to five event
    /// selectors for a trail. You can use either `EventSelectors` or
    /// `AdvancedEventSelectors` in a `PutEventSelectors` request, but not
    /// both. If you apply `EventSelectors` to a trail, any existing
    /// `AdvancedEventSelectors` are overwritten.
    event_selectors: ?[]const EventSelector = null,

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
    /// If you specify a trail ARN, it must be in the following format.
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    trail_name: []const u8,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .event_selectors = "EventSelectors",
        .trail_name = "TrailName",
    };
};

pub const PutEventSelectorsOutput = struct {
    /// Specifies the advanced event selectors configured for your trail.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// Specifies the event selectors configured for your trail.
    event_selectors: ?[]const EventSelector = null,

    /// Specifies the ARN of the trail that was updated with event selectors. The
    /// following is
    /// the format of a trail ARN.
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .event_selectors = "EventSelectors",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEventSelectorsInput, options: CallOptions) !PutEventSelectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEventSelectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.PutEventSelectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEventSelectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutEventSelectorsOutput, body, allocator);
}
