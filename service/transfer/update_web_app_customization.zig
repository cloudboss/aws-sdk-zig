const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateWebAppCustomizationInput = struct {
    /// Specify an icon file data string (in base64 encoding).
    favicon_file: ?[]const u8 = null,

    /// Specify logo file data string (in base64 encoding).
    logo_file: ?[]const u8 = null,

    /// Provide an updated title.
    title: ?[]const u8 = null,

    /// Provide the identifier of the web app that you are updating.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .favicon_file = "FaviconFile",
        .logo_file = "LogoFile",
        .title = "Title",
        .web_app_id = "WebAppId",
    };
};

pub const UpdateWebAppCustomizationOutput = struct {
    /// Returns the unique identifier for the web app being updated.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .web_app_id = "WebAppId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebAppCustomizationInput, options: CallOptions) !UpdateWebAppCustomizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebAppCustomizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.UpdateWebAppCustomization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWebAppCustomizationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateWebAppCustomizationOutput, body, allocator);
}
