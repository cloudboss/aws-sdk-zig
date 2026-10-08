const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityConfiguration = @import("capability_configuration.zig").CapabilityConfiguration;
const S3Location = @import("s3_location.zig").S3Location;
const CapabilityType = @import("capability_type.zig").CapabilityType;

pub const GetCapabilityInput = struct {
    /// Specifies a system-assigned unique identifier for the capability.
    capability_id: []const u8,

    pub const json_field_names = .{
        .capability_id = "capabilityId",
    };
};

pub const GetCapabilityOutput = struct {
    /// Returns an Amazon Resource Name (ARN) for a specific Amazon Web Services
    /// resource, such as a capability, partnership, profile, or transformer.
    capability_arn: []const u8,

    /// Returns a system-assigned unique identifier for the capability.
    capability_id: []const u8,

    /// Returns a structure that contains the details for a capability.
    configuration: ?CapabilityConfiguration = null,

    /// Returns a timestamp for creation date and time of the capability.
    created_at: i64,

    /// Returns one or more locations in Amazon S3, each specifying an EDI document
    /// that can be used with this capability. Each item contains the name of the
    /// bucket and the key, to identify the document's location.
    instructions_documents: ?[]const S3Location = null,

    /// Returns a timestamp for last time the capability was modified.
    modified_at: ?i64 = null,

    /// Returns the name of the capability, used to identify it.
    name: []const u8,

    /// Returns the type of the capability. Currently, only `edi` is supported.
    type: CapabilityType,

    pub const json_field_names = .{
        .capability_arn = "capabilityArn",
        .capability_id = "capabilityId",
        .configuration = "configuration",
        .created_at = "createdAt",
        .instructions_documents = "instructionsDocuments",
        .modified_at = "modifiedAt",
        .name = "name",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCapabilityInput, options: CallOptions) !GetCapabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCapabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.GetCapability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCapabilityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCapabilityOutput, body, allocator);
}
