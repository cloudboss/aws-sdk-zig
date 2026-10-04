const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateAttributesRequest = @import("update_attributes_request.zig").UpdateAttributesRequest;
const AttributesResource = @import("attributes_resource.zig").AttributesResource;

pub const RemoveAttributesInput = struct {
    /// The unique identifier for the application. This identifier is displayed as
    /// the **Project ID** on the Amazon Pinpoint console.
    application_id: []const u8,

    /// The type of attribute or attributes to remove. Valid values are:
    ///
    /// * endpoint-custom-attributes - Custom attributes that describe endpoints,
    ///   such as the date when an associated user opted in or out of receiving
    ///   communications from you through a specific type of channel.
    /// * endpoint-metric-attributes - Custom metrics that your app reports to
    ///   Amazon Pinpoint for endpoints, such as the number of app sessions or the
    ///   number of items left in a cart.
    /// * endpoint-user-attributes - Custom attributes that describe users, such as
    ///   first name, last name, and age.
    attribute_type: []const u8,

    update_attributes_request: UpdateAttributesRequest,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .attribute_type = "AttributeType",
        .update_attributes_request = "UpdateAttributesRequest",
    };
};

pub const RemoveAttributesOutput = struct {
    attributes_resource: ?AttributesResource = null,

    pub const json_field_names = .{
        .attributes_resource = "AttributesResource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveAttributesInput, options: CallOptions) !RemoveAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apps/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/attributes/");
    try path_buf.appendSlice(allocator, input.attribute_type);
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.update_attributes_request, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RemoveAttributesOutput = .{};

    return result;
}
