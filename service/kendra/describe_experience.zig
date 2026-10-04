const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExperienceConfiguration = @import("experience_configuration.zig").ExperienceConfiguration;
const ExperienceEndpoint = @import("experience_endpoint.zig").ExperienceEndpoint;
const ExperienceStatus = @import("experience_status.zig").ExperienceStatus;

pub const DescribeExperienceInput = struct {
    /// The identifier of your Amazon Kendra experience you want to get information
    /// on.
    id: []const u8,

    /// The identifier of the index for your Amazon Kendra experience.
    index_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
    };
};

pub const DescribeExperienceOutput = struct {
    /// Shows the configuration information for your Amazon Kendra experience. This
    /// includes
    /// `ContentSourceConfiguration`, which specifies the data source IDs
    /// and/or FAQ IDs, and `UserIdentityConfiguration`, which specifies the
    /// user or group information to grant access to your Amazon Kendra experience.
    configuration: ?ExperienceConfiguration = null,

    /// The Unix timestamp when your Amazon Kendra experience was created.
    created_at: ?i64 = null,

    /// Shows the description for your Amazon Kendra experience.
    description: ?[]const u8 = null,

    /// Shows the endpoint URLs for your Amazon Kendra experiences. The URLs are
    /// unique and fully
    /// hosted by Amazon Web Services.
    endpoints: ?[]const ExperienceEndpoint = null,

    /// The reason your Amazon Kendra experience could not properly process.
    error_message: ?[]const u8 = null,

    /// Shows the identifier of your Amazon Kendra experience.
    id: ?[]const u8 = null,

    /// Shows the identifier of the index for your Amazon Kendra experience.
    index_id: ?[]const u8 = null,

    /// Shows the name of your Amazon Kendra experience.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role with permission to access
    /// the `Query` API, `QuerySuggestions` API,
    /// `SubmitFeedback` API, and IAM Identity Center that stores
    /// your users and groups information.
    role_arn: ?[]const u8 = null,

    /// The current processing status of your Amazon Kendra experience. When the
    /// status
    /// is `ACTIVE`, your Amazon Kendra experience is ready to use. When the
    /// status is `FAILED`, the `ErrorMessage` field contains
    /// the reason that this failed.
    status: ?ExperienceStatus = null,

    /// The Unix timestamp when your Amazon Kendra experience was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .created_at = "CreatedAt",
        .description = "Description",
        .endpoints = "Endpoints",
        .error_message = "ErrorMessage",
        .id = "Id",
        .index_id = "IndexId",
        .name = "Name",
        .role_arn = "RoleArn",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExperienceInput, options: CallOptions) !DescribeExperienceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExperienceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeExperience");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExperienceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeExperienceOutput, body, allocator);
}
