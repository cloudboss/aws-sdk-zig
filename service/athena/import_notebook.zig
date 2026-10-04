const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotebookType = @import("notebook_type.zig").NotebookType;

pub const ImportNotebookInput = struct {
    /// A unique case-sensitive string used to ensure the request to import the
    /// notebook is
    /// idempotent (executes only once).
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for you. If
    /// you are not
    /// using the Amazon Web Services SDK or the Amazon Web Services CLI, you must
    /// provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// The name of the notebook to import.
    name: []const u8,

    /// A URI that specifies the Amazon S3 location of a notebook file in
    /// `ipynb` format.
    notebook_s3_location_uri: ?[]const u8 = null,

    /// The notebook content to be imported. The payload must be in `ipynb`
    /// format.
    payload: ?[]const u8 = null,

    /// The notebook content type. Currently, the only valid type is
    /// `IPYNB`.
    @"type": NotebookType,

    /// The name of the Spark enabled workgroup to import the notebook to.
    work_group: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .notebook_s3_location_uri = "NotebookS3LocationUri",
        .payload = "Payload",
        .@"type" = "Type",
        .work_group = "WorkGroup",
    };
};

pub const ImportNotebookOutput = struct {
    /// The ID assigned to the imported notebook.
    notebook_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .notebook_id = "NotebookId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportNotebookInput, options: CallOptions) !ImportNotebookOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportNotebookInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.ImportNotebook");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportNotebookOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportNotebookOutput, body, allocator);
}
