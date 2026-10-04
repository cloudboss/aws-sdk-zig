const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConversionSource = @import("conversion_source.zig").ConversionSource;
const ConversionTarget = @import("conversion_target.zig").ConversionTarget;

pub const TestConversionInput = struct {
    /// Specify the source file for an outbound EDI request.
    source: ConversionSource,

    /// Specify the format (X12 is the only currently supported format), and other
    /// details for the conversion target.
    target: ConversionTarget,

    pub const json_field_names = .{
        .source = "source",
        .target = "target",
    };
};

pub const TestConversionOutput = struct {
    /// Returns the converted file content.
    converted_file_content: []const u8,

    /// Returns an array of validation messages that Amazon Web Services B2B Data
    /// Interchange generates during the conversion process. These messages include
    /// both standard EDI validation results and custom validation messages when
    /// custom validation rules are configured. Custom validation messages provide
    /// detailed feedback on element length constraints, code list validations, and
    /// element requirement checks applied during the outbound EDI generation
    /// process.
    validation_messages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .converted_file_content = "convertedFileContent",
        .validation_messages = "validationMessages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestConversionInput, options: CallOptions) !TestConversionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestConversionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.TestConversion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestConversionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(TestConversionOutput, body, allocator);
}
