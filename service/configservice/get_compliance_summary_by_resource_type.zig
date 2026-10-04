const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComplianceSummaryByResourceType = @import("compliance_summary_by_resource_type.zig").ComplianceSummaryByResourceType;

pub const GetComplianceSummaryByResourceTypeInput = struct {
    /// Specify one or more resource types to get the number of
    /// resources that are compliant and the number that are noncompliant
    /// for each resource type.
    ///
    /// For this request, you can specify an Amazon Web Services resource type such
    /// as
    /// `AWS::EC2::Instance`. You can specify that the
    /// resource type is an Amazon Web Services account by specifying
    /// `AWS::::Account`.
    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .resource_types = "ResourceTypes",
    };
};

pub const GetComplianceSummaryByResourceTypeOutput = struct {
    /// The number of resources that are compliant and the number that
    /// are noncompliant. If one or more resource types were provided with
    /// the request, the numbers are returned for each resource type. The
    /// maximum number returned is 100.
    compliance_summaries_by_resource_type: ?[]const ComplianceSummaryByResourceType = null,

    pub const json_field_names = .{
        .compliance_summaries_by_resource_type = "ComplianceSummariesByResourceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComplianceSummaryByResourceTypeInput, options: CallOptions) !GetComplianceSummaryByResourceTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComplianceSummaryByResourceTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetComplianceSummaryByResourceType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComplianceSummaryByResourceTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetComplianceSummaryByResourceTypeOutput, body, allocator);
}
