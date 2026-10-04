const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RollbackServiceSoftwareOptions = @import("rollback_service_software_options.zig").RollbackServiceSoftwareOptions;

pub const RollbackServiceSoftwareUpdateInput = struct {
    /// The name of the domain to roll back the service software update on.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const RollbackServiceSoftwareUpdateOutput = struct {
    /// The rollback options for the service software update.
    rollback_service_software_options: ?RollbackServiceSoftwareOptions = null,

    pub const json_field_names = .{
        .rollback_service_software_options = "RollbackServiceSoftwareOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RollbackServiceSoftwareUpdateInput, options: CallOptions) !RollbackServiceSoftwareUpdateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RollbackServiceSoftwareUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/serviceSoftwareUpdate/rollback";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RollbackServiceSoftwareUpdateOutput {
    var result: RollbackServiceSoftwareUpdateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RollbackServiceSoftwareUpdateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
