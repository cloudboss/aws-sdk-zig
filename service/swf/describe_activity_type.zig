const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActivityType = @import("activity_type.zig").ActivityType;
const ActivityTypeConfiguration = @import("activity_type_configuration.zig").ActivityTypeConfiguration;
const ActivityTypeInfo = @import("activity_type_info.zig").ActivityTypeInfo;

pub const DescribeActivityTypeInput = struct {
    /// The activity type to get information about. Activity types are identified by
    /// the
    /// `name` and `version` that were supplied when the activity was
    /// registered.
    activity_type: ActivityType,

    /// The name of the domain in which the activity type is registered.
    domain: []const u8,

    pub const json_field_names = .{
        .activity_type = "activityType",
        .domain = "domain",
    };
};

pub const DescribeActivityTypeOutput = struct {
    /// The configuration settings registered with the activity type.
    configuration: ?ActivityTypeConfiguration = null,

    /// General information about the activity type.
    ///
    /// The status of activity type (returned in the ActivityTypeInfo structure) can
    /// be one of the following.
    ///
    /// * `REGISTERED` – The type is registered and available. Workers supporting
    ///   this
    /// type should be running.
    ///
    /// * `DEPRECATED` – The type was deprecated using DeprecateActivityType, but is
    /// still in use. You should keep workers supporting this type running.
    /// You cannot create new tasks of this type.
    type_info: ?ActivityTypeInfo = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .type_info = "typeInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeActivityTypeInput, options: CallOptions) !DescribeActivityTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeActivityTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.DescribeActivityType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeActivityTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeActivityTypeOutput, body, allocator);
}
