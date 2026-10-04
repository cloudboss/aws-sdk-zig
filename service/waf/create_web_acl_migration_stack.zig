const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateWebACLMigrationStackInput = struct {
    /// Indicates whether to exclude entities that can't be migrated or to stop the
    /// migration.
    /// Set this to true to ignore unsupported entities in the web ACL during the
    /// migration. Otherwise, if AWS WAF encounters unsupported
    /// entities, it stops the process and throws an exception.
    ignore_unsupported_type: bool,

    /// The name of the Amazon S3 bucket to store the CloudFormation template in.
    /// The S3 bucket must be
    /// configured as follows for the migration:
    ///
    /// * The bucket name must start with `aws-waf-migration-`. For example,
    ///   `aws-waf-migration-my-web-acl`.
    ///
    /// * The bucket must be in the Region where you are deploying the template. For
    ///   example, for a web ACL in us-west-2, you must use an Amazon S3 bucket in
    ///   us-west-2 and you must deploy the template stack to us-west-2.
    ///
    /// * The bucket policies must permit the migration process to write data. For
    ///   listings of the
    /// bucket policies, see the Examples section.
    s3_bucket_name: []const u8,

    /// The UUID of the WAF Classic web ACL that you want to migrate to WAF v2.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .ignore_unsupported_type = "IgnoreUnsupportedType",
        .s3_bucket_name = "S3BucketName",
        .web_acl_id = "WebACLId",
    };
};

pub const CreateWebACLMigrationStackOutput = struct {
    /// The URL of the template created in Amazon S3.
    s3_object_url: []const u8,

    pub const json_field_names = .{
        .s3_object_url = "S3ObjectUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebACLMigrationStackInput, options: CallOptions) !CreateWebACLMigrationStackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebACLMigrationStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf", "WAF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.CreateWebACLMigrationStack");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebACLMigrationStackOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWebACLMigrationStackOutput, body, allocator);
}
