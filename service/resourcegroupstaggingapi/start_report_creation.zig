const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartReportCreationInput = struct {
    /// The name of the Amazon S3 bucket where the report will be stored; for
    /// example:
    ///
    /// `amzn-s3-demo-bucket`
    ///
    /// For more information on S3 bucket requirements, including an example bucket
    /// policy,
    /// see the example Amazon S3 bucket policy on this page.
    s3_bucket: []const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
    };
};

pub const StartReportCreationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartReportCreationInput, options: CallOptions) !StartReportCreationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tagging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartReportCreationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tagging", "Resource Groups Tagging API", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ResourceGroupsTaggingAPI_20170126.StartReportCreation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartReportCreationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
