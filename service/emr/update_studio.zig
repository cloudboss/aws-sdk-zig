const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateStudioInput = struct {
    /// The Amazon S3 location to back up Workspaces and notebook files for the
    /// Amazon EMR Studio.
    default_s3_location: ?[]const u8 = null,

    /// A detailed description to assign to the Amazon EMR Studio.
    description: ?[]const u8 = null,

    /// The KMS key identifier (ARN) used to encrypt Amazon EMR Studio workspace and
    /// notebook files when backed up to Amazon S3.
    encryption_key_arn: ?[]const u8 = null,

    /// A descriptive name for the Amazon EMR Studio.
    name: ?[]const u8 = null,

    /// The ID of the Amazon EMR Studio to update.
    studio_id: []const u8,

    /// A list of subnet IDs to associate with the Amazon EMR Studio. The list can
    /// include new subnet IDs, but must also include all of the subnet IDs
    /// previously associated
    /// with the Studio. The list order does not matter. A Studio can have a maximum
    /// of 5 subnets.
    /// The subnets must belong to the same VPC as the Studio.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .default_s3_location = "DefaultS3Location",
        .description = "Description",
        .encryption_key_arn = "EncryptionKeyArn",
        .name = "Name",
        .studio_id = "StudioId",
        .subnet_ids = "SubnetIds",
    };
};

pub const UpdateStudioOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStudioInput, options: CallOptions) !UpdateStudioOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStudioInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.UpdateStudio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStudioOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
