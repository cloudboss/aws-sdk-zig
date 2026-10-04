const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateFleetAdvisorCollectorInput = struct {
    /// The name of your Fleet Advisor collector (for example, `sample-collector`).
    collector_name: []const u8,

    /// A summary description of your Fleet Advisor collector.
    description: ?[]const u8 = null,

    /// The Amazon S3 bucket that the Fleet Advisor collector uses to store
    /// inventory metadata.
    s3_bucket_name: []const u8,

    /// The IAM role that grants permissions to access the specified Amazon S3
    /// bucket.
    service_access_role_arn: []const u8,

    pub const json_field_names = .{
        .collector_name = "CollectorName",
        .description = "Description",
        .s3_bucket_name = "S3BucketName",
        .service_access_role_arn = "ServiceAccessRoleArn",
    };
};

pub const CreateFleetAdvisorCollectorOutput = struct {
    /// The name of the new Fleet Advisor collector.
    collector_name: ?[]const u8 = null,

    /// The unique ID of the new Fleet Advisor collector, for example:
    /// `22fda70c-40d5-4acf-b233-a495bd8eb7f5`
    collector_referenced_id: ?[]const u8 = null,

    /// A summary description of the Fleet Advisor collector.
    description: ?[]const u8 = null,

    /// The Amazon S3 bucket that the collector uses to store inventory metadata.
    s3_bucket_name: ?[]const u8 = null,

    /// The IAM role that grants permissions to access the specified Amazon S3
    /// bucket.
    service_access_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .collector_name = "CollectorName",
        .collector_referenced_id = "CollectorReferencedId",
        .description = "Description",
        .s3_bucket_name = "S3BucketName",
        .service_access_role_arn = "ServiceAccessRoleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFleetAdvisorCollectorInput, options: CallOptions) !CreateFleetAdvisorCollectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFleetAdvisorCollectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateFleetAdvisorCollector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFleetAdvisorCollectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFleetAdvisorCollectorOutput, body, allocator);
}
