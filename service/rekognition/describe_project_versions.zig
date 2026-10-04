const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectVersionDescription = @import("project_version_description.zig").ProjectVersionDescription;

pub const DescribeProjectVersionsInput = struct {
    /// The maximum number of results to return per paginated call.
    /// The largest value you can specify is 100. If you specify a value greater
    /// than 100, a ValidationException
    /// error occurs. The default value is 100.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more
    /// results to retrieve), Amazon Rekognition returns a pagination token in the
    /// response.
    /// You can use this pagination token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the project that contains the
    /// model/adapter you want
    /// to describe.
    project_arn: []const u8,

    /// A list of model or project version names that you want to describe. You can
    /// add
    /// up to 10 model or project version names to the list. If you don't specify a
    /// value, all
    /// project version descriptions are returned. A version name is part of a
    /// project version ARN. For example, `my-model.2020-01-21T09.10.15` is
    /// the version name in the following ARN.
    /// `arn:aws:rekognition:us-east-1:123456789012:project/getting-started/version/*my-model.2020-01-21T09.10.15*/1234567890123`.
    version_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .project_arn = "ProjectArn",
        .version_names = "VersionNames",
    };
};

pub const DescribeProjectVersionsOutput = struct {
    /// If the previous response was incomplete (because there is more
    /// results to retrieve), Amazon Rekognition returns a pagination token in the
    /// response.
    /// You can use this pagination token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of project version descriptions. The list is sorted by the creation
    /// date and
    /// time of the project versions, latest to earliest.
    project_version_descriptions: ?[]const ProjectVersionDescription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .project_version_descriptions = "ProjectVersionDescriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProjectVersionsInput, options: CallOptions) !DescribeProjectVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProjectVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DescribeProjectVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProjectVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProjectVersionsOutput, body, allocator);
}
