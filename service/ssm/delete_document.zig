const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteDocumentInput = struct {
    /// The version of the document that you want to delete. If not provided, all
    /// versions of the
    /// document are deleted.
    document_version: ?[]const u8 = null,

    /// Some SSM document types require that you specify a `Force` flag before you
    /// can
    /// delete the document. For example, you must specify a `Force` flag to delete
    /// a document
    /// of type `ApplicationConfigurationSchema`. You can restrict access to the
    /// `Force` flag in an Identity and Access Management (IAM) policy.
    force: ?bool = null,

    /// The name of the document.
    name: []const u8,

    /// The version name of the document that you want to delete. If not provided,
    /// all versions of
    /// the document are deleted.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_version = "DocumentVersion",
        .force = "Force",
        .name = "Name",
        .version_name = "VersionName",
    };
};

pub const DeleteDocumentOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDocumentInput, options: CallOptions) !DeleteDocumentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDocumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DeleteDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDocumentOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
