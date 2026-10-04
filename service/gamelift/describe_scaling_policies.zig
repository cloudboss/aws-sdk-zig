const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalingStatusType = @import("scaling_status_type.zig").ScalingStatusType;
const ScalingPolicy = @import("scaling_policy.zig").ScalingPolicy;

pub const DescribeScalingPoliciesInput = struct {
    /// A unique identifier for the fleet for which to retrieve scaling policies.
    /// You can use either the fleet ID or ARN
    /// value.
    fleet_id: []const u8,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// The fleet location. If you don't specify this value, the response contains
    /// the
    /// scaling policies of every location in the fleet.
    location: ?[]const u8 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// Scaling policy status to filter results on. A scaling policy is only in
    /// force when in
    /// an `ACTIVE` status.
    ///
    /// * **ACTIVE** -- The scaling policy is currently in
    /// force.
    ///
    /// * **UPDATEREQUESTED** -- A request to update the
    /// scaling policy has been received.
    ///
    /// * **UPDATING** -- A change is being made to the
    /// scaling policy.
    ///
    /// * **DELETEREQUESTED** -- A request to delete the
    /// scaling policy has been received.
    ///
    /// * **DELETING** -- The scaling policy is being
    /// deleted.
    ///
    /// * **DELETED** -- The scaling policy has been
    /// deleted.
    ///
    /// * **ERROR** -- An error occurred in creating the
    /// policy. It should be removed and recreated.
    status_filter: ?ScalingStatusType = null,

    pub const json_field_names = .{
        .fleet_id = "FleetId",
        .limit = "Limit",
        .location = "Location",
        .next_token = "NextToken",
        .status_filter = "StatusFilter",
    };
};

pub const DescribeScalingPoliciesOutput = struct {
    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    /// A collection of objects containing the scaling policies matching the
    /// request.
    scaling_policies: ?[]const ScalingPolicy = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .scaling_policies = "ScalingPolicies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScalingPoliciesInput, options: CallOptions) !DescribeScalingPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScalingPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeScalingPolicies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScalingPoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeScalingPoliciesOutput, body, allocator);
}
