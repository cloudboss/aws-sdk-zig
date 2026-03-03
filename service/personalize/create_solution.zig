const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SolutionConfig = @import("solution_config.zig").SolutionConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateSolutionInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset group that provides the
    /// training data.
    dataset_group_arn: []const u8,

    /// When your have multiple event types (using an `EVENT_TYPE` schema field),
    /// this parameter specifies which event type (for example, 'click' or 'like')
    /// is used for
    /// training the model.
    ///
    /// If you do not provide an `eventType`, Amazon Personalize will use all
    /// interactions for training with
    /// equal weight regardless of type.
    event_type: ?[]const u8 = null,

    /// The name for the solution.
    name: []const u8,

    /// We don't recommend enabling automated machine learning. Instead, match your
    /// use case to the available Amazon Personalize
    /// recipes. For more information, see [Choosing a
    /// recipe](https://docs.aws.amazon.com/personalize/latest/dg/working-with-predefined-recipes.html).
    ///
    /// Whether to perform automated machine learning (AutoML). The default is
    /// `false`.
    /// For this case, you must specify `recipeArn`.
    ///
    /// When set to `true`, Amazon Personalize analyzes your training data and
    /// selects
    /// the optimal USER_PERSONALIZATION recipe and hyperparameters. In this case,
    /// you must omit
    /// `recipeArn`. Amazon Personalize determines the optimal recipe by running
    /// tests with
    /// different values for the hyperparameters.
    /// AutoML lengthens the training process as compared to selecting a specific
    /// recipe.
    perform_auto_ml: ?bool = null,

    /// Whether the solution uses automatic training to create new solution versions
    /// (trained models). The default is
    /// `True` and the solution automatically creates new solution versions every 7
    /// days. You can change the training
    /// frequency by specifying a `schedulingExpression` in the `AutoTrainingConfig`
    /// as part of solution
    /// configuration. For more information about automatic training,
    /// see [Configuring automatic
    /// training](https://docs.aws.amazon.com/personalize/latest/dg/solution-config-auto-training.html).
    ///
    /// Automatic solution version creation starts within one hour after the
    /// solution is ACTIVE. If you manually create a solution version within
    /// the hour, the solution skips the first automatic training.
    ///
    /// After training starts, you can
    /// get the solution version's Amazon Resource Name (ARN) with the
    /// [ListSolutionVersions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutionVersions.html) API operation.
    /// To get its status, use the
    /// [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html).
    perform_auto_training: ?bool = null,

    /// Whether to perform hyperparameter optimization (HPO) on the specified or
    /// selected recipe.
    /// The default is `false`.
    ///
    /// When performing AutoML, this parameter is always `true` and you
    /// should not set it to `false`.
    perform_hpo: ?bool = null,

    /// Whether to perform incremental training updates on your model. When enabled,
    /// this allows the model to learn from new data more frequently without
    /// requiring full retraining, which enables near real-time personalization.
    /// This parameter is supported only for solutions that use the
    /// semantic-similarity recipe.
    perform_incremental_update: ?bool = null,

    /// The Amazon Resource Name (ARN) of the recipe to use for model training. This
    /// is required when
    /// `performAutoML` is false. For information about different Amazon Personalize
    /// recipes and their ARNs,
    /// see [Choosing a
    /// recipe](https://docs.aws.amazon.com/personalize/latest/dg/working-with-predefined-recipes.html).
    recipe_arn: ?[]const u8 = null,

    /// The configuration properties for the solution. When `performAutoML` is set
    /// to
    /// true, Amazon Personalize only evaluates the `autoMLConfig` section
    /// of the solution configuration.
    ///
    /// Amazon Personalize doesn't support configuring the `hpoObjective`
    /// at this time.
    solution_config: ?SolutionConfig = null,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the solution.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .dataset_group_arn = "datasetGroupArn",
        .event_type = "eventType",
        .name = "name",
        .perform_auto_ml = "performAutoML",
        .perform_auto_training = "performAutoTraining",
        .perform_hpo = "performHPO",
        .perform_incremental_update = "performIncrementalUpdate",
        .recipe_arn = "recipeArn",
        .solution_config = "solutionConfig",
        .tags = "tags",
    };
};

pub const CreateSolutionOutput = struct {
    /// The ARN of the solution.
    solution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .solution_arn = "solutionArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSolutionInput, options: Options) !CreateSolutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "personalize");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSolutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateSolution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSolutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSolutionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
