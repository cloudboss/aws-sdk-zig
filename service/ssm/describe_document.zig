const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentDescription = @import("document_description.zig").DocumentDescription;

pub const DescribeDocumentInput = struct {
    /// The document version for which you want information. Can be a specific
    /// version or the
    /// default version.
    document_version: ?[]const u8 = null,

    /// The name of the SSM document.
    ///
    /// If you're calling a shared SSM document from a different Amazon Web Services
    /// account,
    /// `Name` is the full Amazon Resource Name (ARN) of the document.
    name: []const u8,

    /// An optional field specifying the version of the artifact associated with the
    /// document. For
    /// example, 12.6. This value is unique across all versions of a document, and
    /// can't be
    /// changed.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_version = "DocumentVersion",
        .name = "Name",
        .version_name = "VersionName",
    };
};

pub const DescribeDocumentOutput = struct {
    /// Information about the SSM document.
    document: ?DocumentDescription = null,

    pub const json_field_names = .{
        .document = "Document",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDocumentInput, options: CallOptions) !DescribeDocumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDocumentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDocumentOutput, body, allocator);
}
