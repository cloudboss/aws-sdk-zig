const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupingAttributeDefinition = @import("grouping_attribute_definition.zig").GroupingAttributeDefinition;
const GroupingConfiguration = @import("grouping_configuration.zig").GroupingConfiguration;

pub const PutGroupingConfigurationInput = struct {
    /// An array of grouping attribute definitions that specify how services should
    /// be grouped. Each definition includes a friendly name, source keys to derive
    /// the grouping value from, and an optional default value.
    grouping_attribute_definitions: []const GroupingAttributeDefinition,

    pub const json_field_names = .{
        .grouping_attribute_definitions = "GroupingAttributeDefinitions",
    };
};

pub const PutGroupingConfigurationOutput = struct {
    /// A structure containing the updated grouping configuration, including all
    /// grouping attribute definitions and the timestamp when it was last updated.
    grouping_configuration: ?GroupingConfiguration = null,

    pub const json_field_names = .{
        .grouping_configuration = "GroupingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutGroupingConfigurationInput, options: CallOptions) !PutGroupingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutGroupingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/grouping-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GroupingAttributeDefinitions\":");
    try aws.json.writeValue(@TypeOf(input.grouping_attribute_definitions), input.grouping_attribute_definitions, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutGroupingConfigurationOutput {
    var result: PutGroupingConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutGroupingConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
