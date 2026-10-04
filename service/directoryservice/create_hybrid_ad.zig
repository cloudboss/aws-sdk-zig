const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateHybridADInput = struct {
    /// The unique identifier of the successful directory assessment that validates
    /// your
    /// self-managed AD environment. You must have a successful directory assessment
    /// before you
    /// create a hybrid directory.
    assessment_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the
    /// credentials for the service account used to join hybrid domain controllers
    /// to your
    /// self-managed AD domain. This secret is used once and not stored.
    ///
    /// The secret must contain key-value pairs with keys matching
    /// `customerAdAdminDomainUsername` and
    /// `customerAdAdminDomainPassword`. For example:
    /// `{"customerAdAdminDomainUsername":"carlos_salazar","customerAdAdminDomainPassword":"ExamplePassword123!"}`.
    secret_arn: []const u8,

    /// The tags to be assigned to the directory. Each tag consists of a key and
    /// value pair.
    /// You can specify multiple tags as a list.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
        .secret_arn = "SecretArn",
        .tags = "Tags",
    };
};

pub const CreateHybridADOutput = struct {
    /// The unique identifier of the newly created hybrid directory.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHybridADInput, options: CallOptions) !CreateHybridADOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHybridADInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.CreateHybridAD");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHybridADOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHybridADOutput, body, allocator);
}
