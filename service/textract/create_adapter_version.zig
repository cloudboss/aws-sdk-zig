const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdapterVersionDatasetConfig = @import("adapter_version_dataset_config.zig").AdapterVersionDatasetConfig;
const OutputConfig = @import("output_config.zig").OutputConfig;

pub const CreateAdapterVersionInput = struct {
    /// A string containing a unique ID for the adapter that will receive a new
    /// version.
    adapter_id: []const u8,

    /// Idempotent token is used to recognize the request. If the same token is used
    /// with multiple
    /// CreateAdapterVersion requests, the same session is returned.
    /// This token is employed to avoid unintentionally creating the same session
    /// multiple times.
    client_request_token: ?[]const u8 = null,

    /// Specifies a dataset used to train a new adapter version. Takes a
    /// ManifestS3Object as the
    /// value.
    dataset_config: AdapterVersionDatasetConfig,

    /// The identifier for your AWS Key Management Service key (AWS KMS key). Used
    /// to encrypt your documents.
    kms_key_id: ?[]const u8 = null,

    output_config: OutputConfig,

    /// A set of tags (key-value pairs) that you want to attach to the adapter
    /// version.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .client_request_token = "ClientRequestToken",
        .dataset_config = "DatasetConfig",
        .kms_key_id = "KMSKeyId",
        .output_config = "OutputConfig",
        .tags = "Tags",
    };
};

pub const CreateAdapterVersionOutput = struct {
    /// A string containing the unique ID for the adapter that has received a new
    /// version.
    adapter_id: ?[]const u8 = null,

    /// A string describing the new version of the adapter.
    adapter_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_version = "AdapterVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAdapterVersionInput, options: CallOptions) !CreateAdapterVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAdapterVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.CreateAdapterVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAdapterVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAdapterVersionOutput, body, allocator);
}
