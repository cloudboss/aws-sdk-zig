const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const ParallelDataConfig = @import("parallel_data_config.zig").ParallelDataConfig;
const Tag = @import("tag.zig").Tag;
const ParallelDataStatus = @import("parallel_data_status.zig").ParallelDataStatus;

pub const CreateParallelDataInput = struct {
    /// A unique identifier for the request. This token is automatically generated
    /// when you use
    /// Amazon Translate through an AWS SDK.
    client_token: []const u8,

    /// A custom description for the parallel data resource in Amazon Translate.
    description: ?[]const u8 = null,

    encryption_key: ?EncryptionKey = null,

    /// A custom name for the parallel data resource in Amazon Translate. You must
    /// assign a name
    /// that is unique in the account and region.
    name: []const u8,

    /// Specifies the format and S3 location of the parallel data input file.
    parallel_data_config: ParallelDataConfig,

    /// Tags to be associated with this resource. A tag is a key-value pair that
    /// adds metadata to a resource. Each tag key for the resource must be unique.
    /// For more information, see [
    /// Tagging your
    /// resources](https://docs.aws.amazon.com/translate/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .encryption_key = "EncryptionKey",
        .name = "Name",
        .parallel_data_config = "ParallelDataConfig",
        .tags = "Tags",
    };
};

pub const CreateParallelDataOutput = struct {
    /// The custom name that you assigned to the parallel data resource.
    name: ?[]const u8 = null,

    /// The status of the parallel data resource. When the resource is ready for you
    /// to use, the
    /// status is `ACTIVE`.
    status: ?ParallelDataStatus = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateParallelDataInput, options: CallOptions) !CreateParallelDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "translate", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateParallelDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.CreateParallelData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateParallelDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateParallelDataOutput, body, allocator);
}
