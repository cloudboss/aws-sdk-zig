const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateCsvClassifierRequest = @import("create_csv_classifier_request.zig").CreateCsvClassifierRequest;
const CreateGrokClassifierRequest = @import("create_grok_classifier_request.zig").CreateGrokClassifierRequest;
const CreateJsonClassifierRequest = @import("create_json_classifier_request.zig").CreateJsonClassifierRequest;
const CreateXMLClassifierRequest = @import("create_xml_classifier_request.zig").CreateXMLClassifierRequest;

pub const CreateClassifierInput = struct {
    /// A `CsvClassifier` object specifying the classifier
    /// to create.
    csv_classifier: ?CreateCsvClassifierRequest = null,

    /// A `GrokClassifier` object specifying the classifier
    /// to create.
    grok_classifier: ?CreateGrokClassifierRequest = null,

    /// A `JsonClassifier` object specifying the classifier
    /// to create.
    json_classifier: ?CreateJsonClassifierRequest = null,

    /// An `XMLClassifier` object specifying the classifier
    /// to create.
    xml_classifier: ?CreateXMLClassifierRequest = null,

    pub const json_field_names = .{
        .csv_classifier = "CsvClassifier",
        .grok_classifier = "GrokClassifier",
        .json_classifier = "JsonClassifier",
        .xml_classifier = "XMLClassifier",
    };
};

pub const CreateClassifierOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClassifierInput, options: CallOptions) !CreateClassifierOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClassifierInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateClassifier");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClassifierOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
