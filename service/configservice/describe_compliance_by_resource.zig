const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComplianceType = @import("compliance_type.zig").ComplianceType;
const ComplianceByResource = @import("compliance_by_resource.zig").ComplianceByResource;

pub const DescribeComplianceByResourceInput = struct {
    /// Filters the results by compliance.
    compliance_types: ?[]const ComplianceType = null,

    /// The maximum number of evaluation results returned on each page.
    /// The default is 10. You cannot specify a number greater than 100. If
    /// you specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    /// The ID of the Amazon Web Services resource for which you want compliance
    /// information. You can specify only one resource ID. If you specify a
    /// resource ID, you must also specify a type for
    /// `ResourceType`.
    resource_id: ?[]const u8 = null,

    /// The types of Amazon Web Services resources for which you want compliance
    /// information (for example, `AWS::EC2::Instance`). For this operation, you can
    /// specify that the resource type is an Amazon Web Services account by
    /// specifying `AWS::::Account`.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance_types = "ComplianceTypes",
        .limit = "Limit",
        .next_token = "NextToken",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

pub const DescribeComplianceByResourceOutput = struct {
    /// Indicates whether the specified Amazon Web Services resource complies with
    /// all
    /// of the Config rules that evaluate it.
    compliance_by_resources: ?[]const ComplianceByResource = null,

    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance_by_resources = "ComplianceByResources",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeComplianceByResourceInput, options: CallOptions) !DescribeComplianceByResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeComplianceByResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeComplianceByResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeComplianceByResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeComplianceByResourceOutput, body, allocator);
}
