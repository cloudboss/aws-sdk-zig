const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const SystemTemplateSummary = @import("system_template_summary.zig").SystemTemplateSummary;

pub const CreateSystemTemplateInput = struct {
    /// The namespace version in which the system is to be created.
    ///
    /// If no value is specified, the latest version is used by default.
    compatible_namespace_version: ?i64 = null,

    /// The `DefinitionDocument` used to create the system.
    definition: DefinitionDocument,

    pub const json_field_names = .{
        .compatible_namespace_version = "compatibleNamespaceVersion",
        .definition = "definition",
    };
};

pub const CreateSystemTemplateOutput = struct {
    /// The summary object that describes the created system.
    summary: ?SystemTemplateSummary = null,

    pub const json_field_names = .{
        .summary = "summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSystemTemplateInput, options: CallOptions) !CreateSystemTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSystemTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.CreateSystemTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSystemTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSystemTemplateOutput, body, allocator);
}
