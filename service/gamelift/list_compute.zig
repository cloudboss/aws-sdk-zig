const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListComputeInputStatus = @import("list_compute_input_status.zig").ListComputeInputStatus;
const Compute = @import("compute.zig").Compute;

pub const ListComputeInput = struct {
    /// The status of computes in a managed container fleet, based on the success of
    /// the
    /// latest update deployment.
    ///
    /// * `ACTIVE` -- The compute is deployed with the correct container
    /// definitions. It is ready to process game servers and host game sessions.
    ///
    /// * `IMPAIRED` -- An update deployment to the compute failed, and the
    /// compute is deployed with incorrect container definitions.
    compute_status: ?ListComputeInputStatus = null,

    /// For computes in a managed container fleet, the name of the deployed
    /// container group
    /// definition.
    container_group_definition_name: ?[]const u8 = null,

    /// A unique identifier for the fleet to retrieve compute resources for.
    fleet_id: []const u8,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// The name of a location to retrieve compute resources for. For an Amazon
    /// GameLift Servers Anywhere
    /// fleet, use a custom location. For a managed fleet, provide a
    /// Amazon Web Services Region or Local Zone code (for example: `us-west-2` or
    /// `us-west-2-lax-1`).
    location: ?[]const u8 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_status = "ComputeStatus",
        .container_group_definition_name = "ContainerGroupDefinitionName",
        .fleet_id = "FleetId",
        .limit = "Limit",
        .location = "Location",
        .next_token = "NextToken",
    };
};

pub const ListComputeOutput = struct {
    /// A list of compute resources in the specified fleet.
    compute_list: ?[]const Compute = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_list = "ComputeList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListComputeInput, options: CallOptions) !ListComputeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListComputeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.ListCompute");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListComputeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListComputeOutput, body, allocator);
}
