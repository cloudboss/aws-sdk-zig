const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportTask = @import("import_task.zig").ImportTask;

pub const StartImportTaskInput = struct {
    /// Optional. A unique token that you can provide to prevent the same import
    /// request from
    /// occurring more than once. If you don't provide a token, a token is
    /// automatically
    /// generated.
    ///
    /// Sending more than one `StartImportTask` request with the same client request
    /// token will return information about the original import task with that
    /// client request
    /// token.
    client_request_token: ?[]const u8 = null,

    /// The URL for your import file that you've uploaded to Amazon S3.
    ///
    /// If you're using the Amazon Web Services CLI, this URL is structured as
    /// follows:
    /// `s3://BucketName/ImportFileName.CSV`
    import_url: []const u8,

    /// A descriptive name for this request. You can use this name to filter future
    /// requests
    /// related to this import task, such as identifying applications and servers
    /// that were included
    /// in this import task. We recommend that you use a meaningful name for each
    /// import task.
    name: []const u8,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .import_url = "importUrl",
        .name = "name",
    };
};

pub const StartImportTaskOutput = struct {
    /// An array of information related to the import task request including status
    /// information,
    /// times, IDs, the Amazon S3 Object URL for the import file, and more.
    task: ?ImportTask = null,

    pub const json_field_names = .{
        .task = "task",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportTaskInput, options: CallOptions) !StartImportTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.StartImportTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImportTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartImportTaskOutput, body, allocator);
}
