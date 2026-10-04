const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Location = @import("s3_location.zig").S3Location;

pub const StartTransformerJobInput = struct {
    /// Reserved for future use.
    client_token: ?[]const u8 = null,

    /// Specifies the location of the input file for the transformation. The
    /// location consists of an Amazon S3 bucket and prefix.
    input_file: S3Location,

    /// Specifies the location of the output file for the transformation. The
    /// location consists of an Amazon S3 bucket and prefix.
    output_location: S3Location,

    /// Specifies the system-assigned unique identifier for the transformer.
    transformer_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .input_file = "inputFile",
        .output_location = "outputLocation",
        .transformer_id = "transformerId",
    };
};

pub const StartTransformerJobOutput = struct {
    /// Returns the unique, system-generated identifier for a transformer run.
    transformer_job_id: []const u8,

    pub const json_field_names = .{
        .transformer_job_id = "transformerJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTransformerJobInput, options: CallOptions) !StartTransformerJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTransformerJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.StartTransformerJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTransformerJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartTransformerJobOutput, body, allocator);
}
