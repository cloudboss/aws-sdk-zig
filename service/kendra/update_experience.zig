const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExperienceConfiguration = @import("experience_configuration.zig").ExperienceConfiguration;

pub const UpdateExperienceInput = struct {
    /// Configuration information you want to update for your Amazon Kendra
    /// experience.
    configuration: ?ExperienceConfiguration = null,

    /// A new description for your Amazon Kendra experience.
    description: ?[]const u8 = null,

    /// The identifier of your Amazon Kendra experience you want to update.
    id: []const u8,

    /// The identifier of the index for your Amazon Kendra experience.
    index_id: []const u8,

    /// A new name for your Amazon Kendra experience.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// the `Query` API, `QuerySuggestions` API, `SubmitFeedback`
    /// API, and IAM Identity Center that stores your users and groups information.
    /// For more information, see [IAM roles for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .description = "Description",
        .id = "Id",
        .index_id = "IndexId",
        .name = "Name",
        .role_arn = "RoleArn",
    };
};

pub const UpdateExperienceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExperienceInput, options: CallOptions) !UpdateExperienceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExperienceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.UpdateExperience");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExperienceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
