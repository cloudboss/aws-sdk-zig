const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyBuildResultAssetType = @import("automated_reasoning_policy_build_result_asset_type.zig").AutomatedReasoningPolicyBuildResultAssetType;
const AutomatedReasoningPolicyBuildResultAssets = @import("automated_reasoning_policy_build_result_assets.zig").AutomatedReasoningPolicyBuildResultAssets;

pub const GetAutomatedReasoningPolicyBuildWorkflowResultAssetsInput = struct {
    /// The unique identifier of the specific asset to retrieve when multiple assets
    /// of the same type exist. This is required when retrieving SOURCE_DOCUMENT
    /// assets, as multiple source documents may have been used in the workflow. The
    /// asset ID can be obtained from the asset manifest.
    asset_id: ?[]const u8 = null,

    /// The type of asset to retrieve (e.g., BUILD_LOG, QUALITY_REPORT,
    /// POLICY_DEFINITION, GENERATED_TEST_CASES, POLICY_SCENARIOS, FIDELITY_REPORT,
    /// ASSET_MANIFEST, SOURCE_DOCUMENT).
    asset_type: AutomatedReasoningPolicyBuildResultAssetType,

    /// The unique identifier of the build workflow whose result assets you want to
    /// retrieve.
    build_workflow_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy whose build
    /// workflow assets you want to retrieve.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .asset_type = "assetType",
        .build_workflow_id = "buildWorkflowId",
        .policy_arn = "policyArn",
    };
};

pub const GetAutomatedReasoningPolicyBuildWorkflowResultAssetsOutput = struct {
    /// The requested build workflow asset. This is a union type that returns only
    /// one of the available asset types (logs, reports, or generated artifacts)
    /// based on the specific asset type requested in the API call.
    build_workflow_assets: ?AutomatedReasoningPolicyBuildResultAssets = null,

    /// The unique identifier of the build workflow.
    build_workflow_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .build_workflow_assets = "buildWorkflowAssets",
        .build_workflow_id = "buildWorkflowId",
        .policy_arn = "policyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyBuildWorkflowResultAssetsInput, options: CallOptions) !GetAutomatedReasoningPolicyBuildWorkflowResultAssetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyBuildWorkflowResultAssetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_id);
    try path_buf.appendSlice(allocator, "/result-assets");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "assetType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.asset_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomatedReasoningPolicyBuildWorkflowResultAssetsOutput {
    var result: GetAutomatedReasoningPolicyBuildWorkflowResultAssetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAutomatedReasoningPolicyBuildWorkflowResultAssetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
