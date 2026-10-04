const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentsSource = @import("attachments_source.zig").AttachmentsSource;
const DocumentFormat = @import("document_format.zig").DocumentFormat;
const DocumentDescription = @import("document_description.zig").DocumentDescription;

pub const UpdateDocumentInput = struct {
    /// A list of key-value pairs that describe attachments to a version of a
    /// document.
    attachments: ?[]const AttachmentsSource = null,

    /// A valid JSON or YAML string.
    content: []const u8,

    /// The friendly name of the SSM document that you want to update. This value
    /// can differ for
    /// each version of the document. If you don't specify a value for this
    /// parameter in your request,
    /// the existing value is applied to the new document version.
    display_name: ?[]const u8 = null,

    /// Specify the document format for the new document version. Systems Manager
    /// supports JSON and YAML
    /// documents. JSON is the default format.
    document_format: ?DocumentFormat = null,

    /// The version of the document that you want to update. Currently, Systems
    /// Manager supports updating only
    /// the latest version of the document. You can specify the version number of
    /// the latest version or
    /// use the `$LATEST` variable.
    ///
    /// If you change a document version for a State Manager association, Systems
    /// Manager immediately runs
    /// the association unless you previously specifed the
    /// `apply-only-at-cron-interval`
    /// parameter.
    document_version: ?[]const u8 = null,

    /// The name of the SSM document that you want to update.
    name: []const u8,

    /// Specify a new target type for the document.
    target_type: ?[]const u8 = null,

    /// An optional field specifying the version of the artifact you are updating
    /// with the document.
    /// For example, 12.6. This value is unique across all versions of a document,
    /// and can't be
    /// changed.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .content = "Content",
        .display_name = "DisplayName",
        .document_format = "DocumentFormat",
        .document_version = "DocumentVersion",
        .name = "Name",
        .target_type = "TargetType",
        .version_name = "VersionName",
    };
};

pub const UpdateDocumentOutput = struct {
    /// A description of the document that was updated.
    document_description: ?DocumentDescription = null,

    pub const json_field_names = .{
        .document_description = "DocumentDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDocumentInput, options: CallOptions) !UpdateDocumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDocumentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDocumentOutput, body, allocator);
}
