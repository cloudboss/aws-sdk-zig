const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeThingInput = struct {
    /// The name of the thing.
    thing_name: []const u8,

    pub const json_field_names = .{
        .thing_name = "thingName",
    };
};

pub const DescribeThingOutput = struct {
    /// The thing attributes.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The name of the billing group the thing belongs to.
    billing_group_name: ?[]const u8 = null,

    /// The default MQTT client ID. For a typical device, the thing name is also
    /// used as the default MQTT client ID.
    /// Although we don’t require a mapping between a thing's registry name and its
    /// use of MQTT client IDs, certificates, or
    /// shadow state, we recommend that you choose a thing name and use it as the
    /// MQTT client ID for the registry and the Device Shadow service.
    ///
    /// This lets you better organize your IoT fleet without removing the
    /// flexibility of the underlying device certificate model or shadows.
    default_client_id: ?[]const u8 = null,

    /// The ARN of the thing to describe.
    thing_arn: ?[]const u8 = null,

    /// The ID of the thing to describe.
    thing_id: ?[]const u8 = null,

    /// The name of the thing.
    thing_name: ?[]const u8 = null,

    /// The thing type name.
    thing_type_name: ?[]const u8 = null,

    /// The current version of the thing record in the registry.
    ///
    /// To avoid unintentional changes to the information in the registry, you can
    /// pass
    /// the version information in the `expectedVersion` parameter of the
    /// `UpdateThing` and `DeleteThing` calls.
    version: ?i64 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .billing_group_name = "billingGroupName",
        .default_client_id = "defaultClientId",
        .thing_arn = "thingArn",
        .thing_id = "thingId",
        .thing_name = "thingName",
        .thing_type_name = "thingTypeName",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeThingInput, options: CallOptions) !DescribeThingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeThingOutput {
    var result: DescribeThingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeThingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
