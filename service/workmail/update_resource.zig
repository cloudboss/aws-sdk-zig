const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BookingOptions = @import("booking_options.zig").BookingOptions;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const UpdateResourceInput = struct {
    /// The resource's booking options to be updated.
    booking_options: ?BookingOptions = null,

    /// Updates the resource description.
    description: ?[]const u8 = null,

    /// If enabled, the resource is hidden from the global address list.
    hidden_from_global_address_list: ?bool = null,

    /// The name of the resource to be updated.
    name: ?[]const u8 = null,

    /// The identifier associated with the organization for which the resource is
    /// updated.
    organization_id: []const u8,

    /// The identifier of the resource to be updated.
    ///
    /// The identifier can accept *ResourceId*, *Resourcename*, or *email*. The
    /// following identity formats are available:
    ///
    /// * Resource ID: r-0123456789a0123456789b0123456789
    ///
    /// * Email address: resource@domain.tld
    ///
    /// * Resource name: resource
    resource_id: []const u8,

    /// Updates the resource type.
    @"type": ?ResourceType = null,

    pub const json_field_names = .{
        .booking_options = "BookingOptions",
        .description = "Description",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .name = "Name",
        .organization_id = "OrganizationId",
        .resource_id = "ResourceId",
        .@"type" = "Type",
    };
};

pub const UpdateResourceOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResourceInput, options: CallOptions) !UpdateResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.UpdateResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
