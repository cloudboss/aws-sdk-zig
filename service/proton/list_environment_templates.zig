const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentTemplateSummary = @import("environment_template_summary.zig").EnvironmentTemplateSummary;

pub const ListEnvironmentTemplatesInput = struct {
    /// The maximum number of environment templates to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next environment template in the
    /// array of environment templates, after the list of environment templates
    /// that was previously requested.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEnvironmentTemplatesOutput = struct {
    /// A token that indicates the location of the next environment template in the
    /// array of environment templates, after the current requested list of
    /// environment templates.
    next_token: ?[]const u8 = null,

    /// An array of environment templates with detail data.
    templates: ?[]const EnvironmentTemplateSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .templates = "templates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentTemplatesInput, options: CallOptions) !ListEnvironmentTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListEnvironmentTemplates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentTemplatesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEnvironmentTemplatesOutput, body, allocator);
}
