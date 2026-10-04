const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SolutionUpdateConfig = @import("solution_update_config.zig").SolutionUpdateConfig;

pub const UpdateSolutionInput = struct {
    /// Whether the solution uses automatic training to create new solution versions
    /// (trained models). You can change the training
    /// frequency by specifying a `schedulingExpression` in the `AutoTrainingConfig`
    /// as part of solution
    /// configuration.
    ///
    /// If you turn on automatic training, the first automatic training starts
    /// within one hour after the solution update
    /// completes. If you manually create a solution version within the hour, the
    /// solution skips the first automatic training.
    /// For more information about automatic training,
    /// see [Configuring automatic
    /// training](https://docs.aws.amazon.com/personalize/latest/dg/solution-config-auto-training.html).
    ///
    /// After training starts, you can
    /// get the solution version's Amazon Resource Name (ARN) with the
    /// [ListSolutionVersions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutionVersions.html) API operation.
    /// To get its status, use the
    /// [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html).
    perform_auto_training: ?bool = null,

    /// Whether to perform incremental training updates on your model. When enabled,
    /// this allows the model to learn from new data more frequently without
    /// requiring full retraining, which enables near real-time personalization.
    /// This parameter is supported only for solutions that use the
    /// semantic-similarity recipe.
    perform_incremental_update: ?bool = null,

    /// The Amazon Resource Name (ARN) of the solution to update.
    solution_arn: []const u8,

    /// The new configuration details of the solution.
    solution_update_config: ?SolutionUpdateConfig = null,

    pub const json_field_names = .{
        .perform_auto_training = "performAutoTraining",
        .perform_incremental_update = "performIncrementalUpdate",
        .solution_arn = "solutionArn",
        .solution_update_config = "solutionUpdateConfig",
    };
};

pub const UpdateSolutionOutput = struct {
    /// The same solution Amazon Resource Name (ARN) as given in the request.
    solution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .solution_arn = "solutionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSolutionInput, options: CallOptions) !UpdateSolutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSolutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.UpdateSolution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSolutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSolutionOutput, body, allocator);
}
