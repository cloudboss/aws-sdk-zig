const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TrainingMode = @import("training_mode.zig").TrainingMode;

pub const CreateSolutionVersionInput = struct {
    /// The name of the solution version.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the solution containing the training
    /// configuration
    /// information.
    solution_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the solution version.
    tags: ?[]const Tag = null,

    /// The scope of training to be performed when creating the solution version.
    /// The default is `FULL`. This creates a completely new model based on the
    /// entirety
    /// of the training data from the datasets in your dataset group.
    ///
    /// If you use
    /// [User-Personalization](https://docs.aws.amazon.com/personalize/latest/dg/native-recipe-new-item-USER_PERSONALIZATION.html),
    /// you can specify a training mode of `UPDATE`. This updates the model to
    /// consider new items for recommendations. It is not a full
    /// retraining. You should still complete a full retraining weekly.
    /// If you specify `UPDATE`, Amazon Personalize will stop automatic updates for
    /// the solution version. To resume updates, create a new solution with training
    /// mode set to `FULL`
    /// and deploy it in a campaign.
    /// For more information about automatic updates, see
    /// [Automatic
    /// updates](https://docs.aws.amazon.com/personalize/latest/dg/use-case-recipe-features.html#maintaining-with-automatic-updates).
    ///
    /// The `UPDATE` option can only be used when you already have an active
    /// solution
    /// version created from the input solution using the `FULL` option and the
    /// input
    /// solution was trained with the
    /// [User-Personalization](https://docs.aws.amazon.com/personalize/latest/dg/native-recipe-new-item-USER_PERSONALIZATION.html)
    /// recipe or the legacy
    /// [HRNN-Coldstart](https://docs.aws.amazon.com/personalize/latest/dg/native-recipe-hrnn-coldstart.html) recipe.
    training_mode: ?TrainingMode = null,

    pub const json_field_names = .{
        .name = "name",
        .solution_arn = "solutionArn",
        .tags = "tags",
        .training_mode = "trainingMode",
    };
};

pub const CreateSolutionVersionOutput = struct {
    /// The ARN of the new solution version.
    solution_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .solution_version_arn = "solutionVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSolutionVersionInput, options: CallOptions) !CreateSolutionVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSolutionVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateSolutionVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSolutionVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSolutionVersionOutput, body, allocator);
}
