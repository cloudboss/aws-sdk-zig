const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SystemTemplateDescription = @import("system_template_description.zig").SystemTemplateDescription;

pub const GetSystemTemplateInput = struct {
    /// The ID of the system to get. This ID must be in the user's namespace.
    ///
    /// The ID should be in the following format.
    ///
    /// `urn:tdm:REGION/ACCOUNT ID/default:system:SYSTEMNAME`
    id: []const u8,

    /// The number that specifies the revision of the system to get.
    revision_number: ?i64 = null,

    pub const json_field_names = .{
        .id = "id",
        .revision_number = "revisionNumber",
    };
};

pub const GetSystemTemplateOutput = struct {
    /// An object that contains summary data about the system.
    description: ?SystemTemplateDescription = null,

    pub const json_field_names = .{
        .description = "description",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSystemTemplateInput, options: CallOptions) !GetSystemTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSystemTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.GetSystemTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSystemTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSystemTemplateOutput, body, allocator);
}
