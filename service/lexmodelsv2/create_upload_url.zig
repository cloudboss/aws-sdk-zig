const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateUploadUrlInput = struct {
};

pub const CreateUploadUrlOutput = struct {
    /// An identifier for a unique import job. Use it when you call the
    /// [StartImport](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_StartImport.html) operation.
    import_id: ?[]const u8 = null,

    /// A pre-signed S3 write URL. Upload the zip archive file that contains
    /// the definition of your bot or bot locale.
    upload_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .import_id = "importId",
        .upload_url = "uploadUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUploadUrlInput, options: CallOptions) !CreateUploadUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUploadUrlInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/createuploadurl";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUploadUrlOutput {
    var result: CreateUploadUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateUploadUrlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
