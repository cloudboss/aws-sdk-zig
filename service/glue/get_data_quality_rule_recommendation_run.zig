const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;
const TaskStatusType = @import("task_status_type.zig").TaskStatusType;

pub const GetDataQualityRuleRecommendationRunInput = struct {
    /// The unique run identifier associated with this run.
    run_id: []const u8,

    pub const json_field_names = .{
        .run_id = "RunId",
    };
};

pub const GetDataQualityRuleRecommendationRunOutput = struct {
    /// The date and time when this run was completed.
    completed_on: ?i64 = null,

    /// The name of the ruleset that was created by the run.
    created_ruleset_name: ?[]const u8 = null,

    /// The name of the security configuration created with the data quality
    /// encryption option.
    data_quality_security_configuration: ?[]const u8 = null,

    /// The data source (an Glue table) associated with this run.
    data_source: ?DataSource = null,

    /// The error strings that are associated with the run.
    error_string: ?[]const u8 = null,

    /// The amount of time (in seconds) that the run consumed resources.
    execution_time: ?i32 = null,

    /// A timestamp. The last point in time when this data quality rule
    /// recommendation run was modified.
    last_modified_on: ?i64 = null,

    /// The number of `G.1X` workers to be used in the run. The default is 5.
    number_of_workers: ?i32 = null,

    /// When a start rule recommendation run completes, it creates a recommended
    /// ruleset (a set of rules). This member has those rules in Data Quality
    /// Definition Language (DQDL) format.
    recommended_ruleset: ?[]const u8 = null,

    /// An IAM role supplied to encrypt the results of the run.
    role: ?[]const u8 = null,

    /// The unique run identifier associated with this run.
    run_id: ?[]const u8 = null,

    /// The date and time when this run started.
    started_on: ?i64 = null,

    /// The status for this run.
    status: ?TaskStatusType = null,

    /// The timeout for a run in minutes. This is the maximum time that a run can
    /// consume resources before it is terminated and enters `TIMEOUT` status. The
    /// default is 2,880 minutes (48 hours).
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .completed_on = "CompletedOn",
        .created_ruleset_name = "CreatedRulesetName",
        .data_quality_security_configuration = "DataQualitySecurityConfiguration",
        .data_source = "DataSource",
        .error_string = "ErrorString",
        .execution_time = "ExecutionTime",
        .last_modified_on = "LastModifiedOn",
        .number_of_workers = "NumberOfWorkers",
        .recommended_ruleset = "RecommendedRuleset",
        .role = "Role",
        .run_id = "RunId",
        .started_on = "StartedOn",
        .status = "Status",
        .timeout = "Timeout",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataQualityRuleRecommendationRunInput, options: CallOptions) !GetDataQualityRuleRecommendationRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataQualityRuleRecommendationRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetDataQualityRuleRecommendationRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataQualityRuleRecommendationRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDataQualityRuleRecommendationRunOutput, body, allocator);
}
