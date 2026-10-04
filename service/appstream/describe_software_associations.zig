const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SoftwareAssociations = @import("software_associations.zig").SoftwareAssociations;

pub const DescribeSoftwareAssociationsInput = struct {
    /// The ARN of the resource to describe software associations. Possible
    /// resources are Image and ImageBuilder.
    associated_resource: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The pagination token to use to retrieve the next page of results for this
    /// operation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_resource = "AssociatedResource",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeSoftwareAssociationsOutput = struct {
    /// The ARN of the resource to describe software associations.
    associated_resource: ?[]const u8 = null,

    /// The pagination token to use to retrieve the next page of results for this
    /// operation.
    next_token: ?[]const u8 = null,

    /// Collection of license included applications association details including:
    ///
    /// * License included application name and version information
    ///
    /// * Deployment status (SoftwareDeploymentStatus enum)
    ///
    /// * Error details for failed deployments
    ///
    /// * Association timestamps
    software_associations: ?[]const SoftwareAssociations = null,

    pub const json_field_names = .{
        .associated_resource = "AssociatedResource",
        .next_token = "NextToken",
        .software_associations = "SoftwareAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSoftwareAssociationsInput, options: CallOptions) !DescribeSoftwareAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSoftwareAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.DescribeSoftwareAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSoftwareAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSoftwareAssociationsOutput, body, allocator);
}
