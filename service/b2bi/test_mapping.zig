const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileFormat = @import("file_format.zig").FileFormat;

pub const TestMappingInput = struct {
    /// Specifies that the currently supported file formats for EDI transformations
    /// are `JSON` and `XML`.
    file_format: FileFormat,

    /// Specify the contents of the EDI (electronic data interchange) XML or JSON
    /// file that is used as input for the transform.
    input_file_content: []const u8,

    /// Specifies the mapping template for the transformer. This template is used to
    /// map the parsed EDI file using JSONata or XSLT.
    ///
    /// This parameter is available for backwards compatibility. Use the
    /// [Mapping](https://docs.aws.amazon.com/b2bi/latest/APIReference/API_Mapping.html) data type instead.
    mapping_template: []const u8,

    pub const json_field_names = .{
        .file_format = "fileFormat",
        .input_file_content = "inputFileContent",
        .mapping_template = "mappingTemplate",
    };
};

pub const TestMappingOutput = struct {
    /// Returns a string for the mapping that can be used to identify the mapping.
    /// Similar to a fingerprint
    mapped_file_content: []const u8,

    pub const json_field_names = .{
        .mapped_file_content = "mappedFileContent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestMappingInput, options: CallOptions) !TestMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "b2bi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.TestMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestMappingOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(TestMappingOutput, body, allocator);
}
