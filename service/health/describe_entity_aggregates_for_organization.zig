const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationEntityAggregate = @import("organization_entity_aggregate.zig").OrganizationEntityAggregate;

pub const DescribeEntityAggregatesForOrganizationInput = struct {
    /// A list of 12-digit Amazon Web Services account numbers that contains the
    /// affected entities.
    aws_account_ids: ?[]const []const u8 = null,

    /// A list of event ARNs (unique identifiers). For example:
    /// `"arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-CDE456", "arn:aws:health:us-west-1::event/EBS/AWS_EBS_LOST_VOLUME/AWS_EBS_LOST_VOLUME_CHI789_JKL101"`
    event_arns: []const []const u8,

    pub const json_field_names = .{
        .aws_account_ids = "awsAccountIds",
        .event_arns = "eventArns",
    };
};

pub const DescribeEntityAggregatesForOrganizationOutput = struct {
    /// The list of entity aggregates for each of the specified accounts that are
    /// affected by each of the specified events.
    organization_entity_aggregates: ?[]const OrganizationEntityAggregate = null,

    pub const json_field_names = .{
        .organization_entity_aggregates = "organizationEntityAggregates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEntityAggregatesForOrganizationInput, options: CallOptions) !DescribeEntityAggregatesForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEntityAggregatesForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeEntityAggregatesForOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEntityAggregatesForOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEntityAggregatesForOrganizationOutput, body, allocator);
}
