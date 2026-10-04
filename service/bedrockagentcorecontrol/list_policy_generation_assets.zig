const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyGenerationAsset = @import("policy_generation_asset.zig").PolicyGenerationAsset;

pub const ListPolicyGenerationAssetsInput = struct {
    /// The maximum number of policy generation assets to return in a single
    /// response. If not specified, the default is 10 assets per page, with a
    /// maximum of 100 per page. This helps control response size when dealing with
    /// policy generations that produce many alternative policy options.
    max_results: ?i32 = null,

    /// A pagination token returned from a previous
    /// [ListPolicyGenerationAssets](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_ListPolicyGenerationAssets.html) call. Use this token to retrieve the next page of assets when the response is paginated due to large numbers of generated policy options.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the policy engine associated with the policy
    /// generation request. This provides the context for the generation operation
    /// and ensures assets are retrieved from the correct policy engine.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy generation request whose assets are to
    /// be retrieved. This must be a valid generation ID from a previous
    /// [StartPolicyGeneration](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_StartPolicyGeneration.html) call that has completed processing.
    policy_generation_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .policy_engine_id = "policyEngineId",
        .policy_generation_id = "policyGenerationId",
    };
};

pub const ListPolicyGenerationAssetsOutput = struct {
    /// A pagination token that can be used in subsequent
    /// [ListPolicyGenerationAssets](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_ListPolicyGenerationAssets.html) calls to retrieve additional assets. This token is only present when there are more generated policy assets available beyond the current response.
    next_token: ?[]const u8 = null,

    /// An array of generated policy assets including Dogwood policies and related
    /// artifacts from the AI-powered policy generation process. Each asset
    /// represents a different policy option or variation generated from the
    /// original natural language input.
    policy_generation_assets: ?[]const PolicyGenerationAsset = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .policy_generation_assets = "policyGenerationAssets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPolicyGenerationAssetsInput, options: CallOptions) !ListPolicyGenerationAssetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPolicyGenerationAssetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policy-generations/");
    try path_buf.appendSlice(allocator, input.policy_generation_id);
    try path_buf.appendSlice(allocator, "/assets");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPolicyGenerationAssetsOutput {
    const result: ListPolicyGenerationAssetsOutput = try aws.json.parseJsonObject(
        ListPolicyGenerationAssetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
