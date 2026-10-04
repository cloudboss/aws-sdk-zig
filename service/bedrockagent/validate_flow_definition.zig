const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowDefinition = @import("flow_definition.zig").FlowDefinition;
const FlowValidation = @import("flow_validation.zig").FlowValidation;

pub const ValidateFlowDefinitionInput = struct {
    /// The definition of a flow to validate.
    definition: FlowDefinition,

    pub const json_field_names = .{
        .definition = "definition",
    };
};

pub const ValidateFlowDefinitionOutput = struct {
    /// Contains an array of objects, each of which contains an error identified by
    /// validation.
    validations: ?[]const FlowValidation = null,

    pub const json_field_names = .{
        .validations = "validations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateFlowDefinitionInput, options: CallOptions) !ValidateFlowDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateFlowDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/flows/validate-definition";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"definition\":");
    try aws.json.writeValue(@TypeOf(input.definition), input.definition, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateFlowDefinitionOutput {
    var result: ValidateFlowDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ValidateFlowDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
