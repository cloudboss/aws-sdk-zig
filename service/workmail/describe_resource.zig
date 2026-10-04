const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BookingOptions = @import("booking_options.zig").BookingOptions;
const EntityState = @import("entity_state.zig").EntityState;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const DescribeResourceInput = struct {
    /// The identifier associated with the organization for which the resource is
    /// described.
    organization_id: []const u8,

    /// The identifier of the resource to be described.
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

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
        .resource_id = "ResourceId",
    };
};

pub const DescribeResourceOutput = struct {
    /// The booking options for the described resource.
    booking_options: ?BookingOptions = null,

    /// Description of the resource.
    description: ?[]const u8 = null,

    /// The date and time when a resource was disabled from WorkMail, in UNIX epoch
    /// time
    /// format.
    disabled_date: ?i64 = null,

    /// The email of the described resource.
    email: ?[]const u8 = null,

    /// The date and time when a resource was enabled for WorkMail, in UNIX epoch
    /// time
    /// format.
    enabled_date: ?i64 = null,

    /// If enabled, the resource is hidden from the global address list.
    hidden_from_global_address_list: ?bool = null,

    /// The name of the described resource.
    name: ?[]const u8 = null,

    /// The identifier of the described resource.
    resource_id: ?[]const u8 = null,

    /// The state of the resource: enabled (registered to WorkMail), disabled
    /// (deregistered
    /// or never registered to WorkMail), or deleted.
    state: ?EntityState = null,

    /// The type of the described resource.
    @"type": ?ResourceType = null,

    pub const json_field_names = .{
        .booking_options = "BookingOptions",
        .description = "Description",
        .disabled_date = "DisabledDate",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .name = "Name",
        .resource_id = "ResourceId",
        .state = "State",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeResourceInput, options: CallOptions) !DescribeResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeResourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeResourceOutput, body, allocator);
}
