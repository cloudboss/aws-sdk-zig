const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Domain = @import("domain.zig").Domain;
const Tag = @import("tag.zig").Tag;

pub const CreateDatasetGroupInput = struct {
    /// An array of Amazon Resource Names (ARNs) of the datasets that you want to
    /// include in the
    /// dataset group.
    dataset_arns: ?[]const []const u8 = null,

    /// A name for the dataset group.
    dataset_group_name: []const u8,

    /// The domain associated with the dataset group. When you add a dataset to a
    /// dataset group,
    /// this value and the value specified for the `Domain` parameter of the
    /// [CreateDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDataset.html)
    /// operation must match.
    ///
    /// The `Domain` and `DatasetType` that you choose determine the fields
    /// that must be present in training data that you import to a dataset. For
    /// example, if you choose
    /// the `RETAIL` domain and `TARGET_TIME_SERIES` as the
    /// `DatasetType`, Amazon Forecast requires that `item_id`,
    /// `timestamp`, and `demand` fields are present in your data. For more
    /// information, see [Dataset
    /// groups](https://docs.aws.amazon.com/forecast/latest/dg/howitworks-datasets-groups.html).
    domain: Domain,

    /// The optional metadata that you apply to the dataset group to help you
    /// categorize and
    /// organize them. Each tag consists of a key and an optional value, both of
    /// which you
    /// define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one
    /// value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    ///
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that
    /// other services may have restrictions on allowed characters. Generally
    /// allowed characters
    /// are: letters, numbers, and spaces representable in UTF-8, and the following
    /// characters: +
    /// - = . _ : / @.
    ///
    /// * Tag keys and values are case sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination
    /// of such as a prefix for keys as it is reserved for Amazon Web Services use.
    /// You cannot edit or delete tag
    /// keys with this prefix. Values can have this prefix. If a tag value has `aws`
    /// as
    /// its prefix but the key does not, then Forecast considers it to be a user tag
    /// and will
    /// count against the limit of 50 tags. Tags with only the key prefix of `aws`
    /// do
    /// not count against your tags per resource limit.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .dataset_arns = "DatasetArns",
        .dataset_group_name = "DatasetGroupName",
        .domain = "Domain",
        .tags = "Tags",
    };
};

pub const CreateDatasetGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset group.
    dataset_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_group_arn = "DatasetGroupArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetGroupInput, options: Options) !CreateDatasetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "forecast");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDatasetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonForecast.CreateDatasetGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDatasetGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetGroupOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
