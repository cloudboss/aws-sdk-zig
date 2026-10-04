const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedOptions = @import("advanced_options.zig").AdvancedOptions;
const EdiType = @import("edi_type.zig").EdiType;
const FileFormat = @import("file_format.zig").FileFormat;
const S3Location = @import("s3_location.zig").S3Location;

pub const TestParsingInput = struct {
    /// Specifies advanced options for parsing the input EDI file. These options
    /// allow for more granular control over the parsing process, including split
    /// options for X12 files.
    advanced_options: ?AdvancedOptions = null,

    /// Specifies the details for the EDI standard that is being used for the
    /// transformer. Currently, only X12 is supported. X12 is a set of standards and
    /// corresponding messages that define specific business documents.
    edi_type: EdiType,

    /// Specifies that the currently supported file formats for EDI transformations
    /// are `JSON` and `XML`.
    file_format: FileFormat,

    /// Specifies an `S3Location` object, which contains the Amazon S3 bucket and
    /// prefix for the location of the input file.
    input_file: S3Location,

    pub const json_field_names = .{
        .advanced_options = "advancedOptions",
        .edi_type = "ediType",
        .file_format = "fileFormat",
        .input_file = "inputFile",
    };
};

pub const TestParsingOutput = struct {
    /// Returns the contents of the input file being tested, parsed according to the
    /// specified EDI (electronic data interchange) type.
    parsed_file_content: []const u8,

    /// Returns an array of parsed file contents when the input file is split
    /// according to the specified split options. Each element in the array
    /// represents a separate split file's parsed content.
    parsed_split_file_contents: ?[]const []const u8 = null,

    /// Returns an array of validation messages generated during EDI validation.
    /// These messages provide detailed information about validation errors,
    /// warnings, or confirmations based on the configured X12 validation rules such
    /// as element length constraints, code list validations, and element
    /// requirement checks. This field is populated when the `TestParsing` API
    /// validates EDI documents.
    validation_messages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .parsed_file_content = "parsedFileContent",
        .parsed_split_file_contents = "parsedSplitFileContents",
        .validation_messages = "validationMessages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestParsingInput, options: CallOptions) !TestParsingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestParsingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.TestParsing");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestParsingOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(TestParsingOutput, body, allocator);
}
