const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const EvaluatorConfig = @import("evaluator_config.zig").EvaluatorConfig;
const EvaluatorType = @import("evaluator_type.zig").EvaluatorType;
const EvaluatorLevel = @import("evaluator_level.zig").EvaluatorLevel;
const Provider = @import("provider.zig").Provider;
const EvaluatorStatus = @import("evaluator_status.zig").EvaluatorStatus;

pub const GetEvaluatorInput = struct {
    /// The unique identifier of the evaluator to retrieve. Can be a built-in
    /// evaluator ID (e.g., Builtin.Helpfulness) or a custom evaluator ID.
    evaluator_id: []const u8,

    /// Controls which data is returned in the response. `ALL_DATA` (default)
    /// returns the full evaluator including decrypted instructions and rating
    /// scale. For evaluators encrypted with a customer managed KMS key, this
    /// requires `kms:Decrypt` permission on the key. `METADATA_ONLY` returns
    /// evaluator metadata and model configuration without instructions or rating
    /// scale, and does not require any KMS permissions.
    included_data: ?IncludedData = null,

    pub const json_field_names = .{
        .evaluator_id = "evaluatorId",
        .included_data = "includedData",
    };
};

pub const GetEvaluatorOutput = struct {
    /// The timestamp when the evaluator was created.
    created_at: i64,

    /// The description of the evaluator.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the evaluator.
    evaluator_arn: []const u8,

    /// The configuration of the evaluator, including LLM-as-a-Judge or code-based
    /// settings.
    evaluator_config: ?EvaluatorConfig = null,

    /// The unique identifier of the evaluator.
    evaluator_id: []const u8,

    /// The name of the evaluator.
    evaluator_name: []const u8,

    /// The kind of evaluator resource. Valid values:
    ///
    /// * `Builtin` – An Amazon Web Services-managed global evaluator.
    /// * `ThirdParty` – An Amazon Web Services-managed global evaluator from a
    ///   third-party provider.
    /// * `Custom` – A customer-created evaluator.
    /// * `CustomCode` – A customer-created code-based evaluator.
    /// * `CustomDerived` – A customer-created evaluator derived from an existing
    ///   base evaluator.
    evaluator_type: ?EvaluatorType = null,

    /// The Amazon Resource Name (ARN) of the customer managed KMS key used to
    /// encrypt the evaluator's sensitive data. This field is only present for
    /// evaluators encrypted with a customer managed key.
    kms_key_arn: ?[]const u8 = null,

    /// The evaluation level (`TOOL_CALL`, `TRACE`, or `SESSION`) that determines
    /// the scope of evaluation.
    level: EvaluatorLevel,

    /// Whether the evaluator is locked for modification due to being referenced by
    /// active online evaluation configurations.
    locked_for_modification: ?bool = null,

    /// The source of the evaluator's logic: Amazon Web Services, a third-party
    /// library, or you.
    provider: ?Provider = null,

    /// The current status of the evaluator.
    status: EvaluatorStatus,

    /// The timestamp when the evaluator was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .evaluator_arn = "evaluatorArn",
        .evaluator_config = "evaluatorConfig",
        .evaluator_id = "evaluatorId",
        .evaluator_name = "evaluatorName",
        .evaluator_type = "evaluatorType",
        .kms_key_arn = "kmsKeyArn",
        .level = "level",
        .locked_for_modification = "lockedForModification",
        .provider = "provider",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEvaluatorInput, options: CallOptions) !GetEvaluatorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEvaluatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/evaluators/");
    try path_buf.appendSlice(allocator, input.evaluator_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.included_data) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includedData=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEvaluatorOutput {
    const result: GetEvaluatorOutput = try aws.json.parseJsonObject(
        GetEvaluatorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
