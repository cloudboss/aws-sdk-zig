const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionConfiguration = @import("execution_configuration.zig").ExecutionConfiguration;

pub const UpdateDataIntegrationAssociationInput = struct {
    /// A unique identifier. of the DataIntegrationAssociation resource
    data_integration_association_identifier: []const u8,

    /// A unique identifier for the DataIntegration.
    data_integration_identifier: []const u8,

    /// The configuration for how the files should be pulled from the source.
    execution_configuration: ExecutionConfiguration,

    pub const json_field_names = .{
        .data_integration_association_identifier = "DataIntegrationAssociationIdentifier",
        .data_integration_identifier = "DataIntegrationIdentifier",
        .execution_configuration = "ExecutionConfiguration",
    };
};

pub const UpdateDataIntegrationAssociationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataIntegrationAssociationInput, options: CallOptions) !UpdateDataIntegrationAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "app-integrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataIntegrationAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("app-integrations", "AppIntegrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dataIntegrations/");
    try path_buf.appendSlice(allocator, input.data_integration_identifier);
    try path_buf.appendSlice(allocator, "/associations/");
    try path_buf.appendSlice(allocator, input.data_integration_association_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExecutionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.execution_configuration), input.execution_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataIntegrationAssociationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateDataIntegrationAssociationOutput = .{};

    return result;
}
