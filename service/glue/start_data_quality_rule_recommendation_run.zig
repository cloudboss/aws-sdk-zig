const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityRuleRecommendationRunAdditionalRunOptions = @import("data_quality_rule_recommendation_run_additional_run_options.zig").DataQualityRuleRecommendationRunAdditionalRunOptions;
const DataSource = @import("data_source.zig").DataSource;
const RecommendationMode = @import("recommendation_mode.zig").RecommendationMode;

pub const StartDataQualityRuleRecommendationRunInput = struct {
    /// Additional run options you can specify for a recommendation run.
    additional_run_options: ?DataQualityRuleRecommendationRunAdditionalRunOptions = null,

    /// Used for idempotency and is recommended to be set to a random ID (such as a
    /// UUID) to avoid creating or starting multiple instances of the same resource.
    client_token: ?[]const u8 = null,

    /// A name for the ruleset.
    created_ruleset_name: ?[]const u8 = null,

    /// The name of the security configuration created with the data quality
    /// encryption option.
    data_quality_security_configuration: ?[]const u8 = null,

    /// The data source (Glue table) associated with this run.
    data_source: DataSource,

    /// The number of `G.1X` workers to be used in the run. The default is 5.
    number_of_workers: ?i32 = null,

    /// The mode that Glue Data Quality uses to recommend rules.
    ///
    /// The default is `BASIC`.
    recommendation_mode: ?RecommendationMode = null,

    /// The IAM role that Glue assumes to access resources for the run.
    ///
    /// For more information, see [Configure IAM permissions for Glue Data
    /// Quality](https://docs.aws.amazon.com/glue/latest/dg/data-quality-authorization.html).
    role: []const u8,

    /// The timeout for a run in minutes. This is the maximum time that a run can
    /// consume resources before it is terminated and enters `TIMEOUT` status. The
    /// default is 2,880 minutes (48 hours).
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .additional_run_options = "AdditionalRunOptions",
        .client_token = "ClientToken",
        .created_ruleset_name = "CreatedRulesetName",
        .data_quality_security_configuration = "DataQualitySecurityConfiguration",
        .data_source = "DataSource",
        .number_of_workers = "NumberOfWorkers",
        .recommendation_mode = "RecommendationMode",
        .role = "Role",
        .timeout = "Timeout",
    };
};

pub const StartDataQualityRuleRecommendationRunOutput = struct {
    /// The unique run identifier associated with this run.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .run_id = "RunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataQualityRuleRecommendationRunInput, options: CallOptions) !StartDataQualityRuleRecommendationRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataQualityRuleRecommendationRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.StartDataQualityRuleRecommendationRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataQualityRuleRecommendationRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDataQualityRuleRecommendationRunOutput, body, allocator);
}
