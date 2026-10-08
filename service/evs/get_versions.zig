const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceTypeEsxVersionsInfo = @import("instance_type_esx_versions_info.zig").InstanceTypeEsxVersionsInfo;
const VcfVersionInfo = @import("vcf_version_info.zig").VcfVersionInfo;

pub const GetVersionsInput = struct {};

pub const GetVersionsOutput = struct {
    /// A list of EC2 instance types and their available ESX versions.
    instance_type_esx_versions: ?[]const InstanceTypeEsxVersionsInfo = null,

    /// A list of VCF versions with their availability status, default ESX version,
    /// and instance types.
    vcf_versions: ?[]const VcfVersionInfo = null,

    pub const json_field_names = .{
        .instance_type_esx_versions = "instanceTypeEsxVersions",
        .vcf_versions = "vcfVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVersionsInput, options: CallOptions) !GetVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVersionsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.GetVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetVersionsOutput, body, allocator);
}
