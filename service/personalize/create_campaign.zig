const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CampaignConfig = @import("campaign_config.zig").CampaignConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateCampaignInput = struct {
    /// The configuration details of a campaign.
    campaign_config: ?CampaignConfig = null,

    /// Specifies the requested minimum provisioned transactions (recommendations)
    /// per second that
    /// Amazon Personalize will support. A high `minProvisionedTPS` will increase
    /// your bill. We recommend starting with 1 for `minProvisionedTPS` (the
    /// default). Track
    /// your usage using Amazon CloudWatch metrics, and increase the
    /// `minProvisionedTPS` as necessary.
    min_provisioned_tps: ?i32 = null,

    /// A name for the new campaign. The campaign name must be unique within your
    /// account.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the trained model to deploy with the
    /// campaign. To specify the latest solution version of your solution,
    /// specify the ARN of your *solution* in `SolutionArn/$LATEST` format.
    /// You must use this format if you set `syncWithLatestSolutionVersion` to
    /// `True` in the
    /// [CampaignConfig](https://docs.aws.amazon.com/personalize/latest/dg/API_CampaignConfig.html).
    ///
    /// To deploy a model that isn't the latest solution version of your solution,
    /// specify the ARN of the solution version.
    ///
    /// For more information about automatic campaign updates, see
    /// [Enabling automatic campaign
    /// updates](https://docs.aws.amazon.com/personalize/latest/dg/campaigns.html#create-campaign-automatic-latest-sv-update).
    solution_version_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the campaign.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .campaign_config = "campaignConfig",
        .min_provisioned_tps = "minProvisionedTPS",
        .name = "name",
        .solution_version_arn = "solutionVersionArn",
        .tags = "tags",
    };
};

pub const CreateCampaignOutput = struct {
    /// The Amazon Resource Name (ARN) of the campaign.
    campaign_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCampaignInput, options: Options) !CreateCampaignOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCampaignInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateCampaign");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCampaignOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCampaignOutput, body, allocator);
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
