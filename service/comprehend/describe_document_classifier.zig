const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentClassifierProperties = @import("document_classifier_properties.zig").DocumentClassifierProperties;

pub const DescribeDocumentClassifierInput = struct {
    /// The Amazon Resource Name (ARN) that identifies the document classifier. The
    /// `CreateDocumentClassifier` operation returns this identifier in its
    /// response.
    document_classifier_arn: []const u8,

    pub const json_field_names = .{
        .document_classifier_arn = "DocumentClassifierArn",
    };
};

pub const DescribeDocumentClassifierOutput = struct {
    /// An object that contains the properties associated with a document
    /// classifier.
    document_classifier_properties: ?DocumentClassifierProperties = null,

    pub const json_field_names = .{
        .document_classifier_properties = "DocumentClassifierProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDocumentClassifierInput, options: CallOptions) !DescribeDocumentClassifierOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDocumentClassifierInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DescribeDocumentClassifier");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDocumentClassifierOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDocumentClassifierOutput, body, allocator);
}
