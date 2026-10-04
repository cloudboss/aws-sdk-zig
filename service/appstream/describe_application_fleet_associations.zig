const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationFleetAssociation = @import("application_fleet_association.zig").ApplicationFleetAssociation;

pub const DescribeApplicationFleetAssociationsInput = struct {
    /// The ARN of the application.
    application_arn: ?[]const u8 = null,

    /// The name of the fleet.
    fleet_name: ?[]const u8 = null,

    /// The maximum size of each page of results.
    max_results: ?i32 = null,

    /// The pagination token used to retrieve the next page of results for this
    /// operation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .fleet_name = "FleetName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeApplicationFleetAssociationsOutput = struct {
    /// The application fleet associations in the list.
    application_fleet_associations: ?[]const ApplicationFleetAssociation = null,

    /// The pagination token used to retrieve the next page of results for this
    /// operation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_fleet_associations = "ApplicationFleetAssociations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationFleetAssociationsInput, options: CallOptions) !DescribeApplicationFleetAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationFleetAssociationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.DescribeApplicationFleetAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationFleetAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeApplicationFleetAssociationsOutput, body, allocator);
}
