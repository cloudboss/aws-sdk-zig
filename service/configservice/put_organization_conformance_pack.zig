const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConformancePackInputParameter = @import("conformance_pack_input_parameter.zig").ConformancePackInputParameter;
const Tag = @import("tag.zig").Tag;

pub const PutOrganizationConformancePackInput = struct {
    /// A list of `ConformancePackInputParameter` objects.
    conformance_pack_input_parameters: ?[]const ConformancePackInputParameter = null,

    /// The name of the Amazon S3 bucket where Config stores conformance pack
    /// templates.
    ///
    /// This field is optional. If used, it must be prefixed with
    /// `awsconfigconforms`.
    delivery_s3_bucket: ?[]const u8 = null,

    /// The prefix for the Amazon S3 bucket.
    ///
    /// This field is optional.
    delivery_s3_key_prefix: ?[]const u8 = null,

    /// A list of Amazon Web Services accounts to be excluded from an organization
    /// conformance pack while deploying a conformance pack.
    excluded_accounts: ?[]const []const u8 = null,

    /// Name of the organization conformance pack you want to create.
    organization_conformance_pack_name: []const u8,

    /// The tags for the organization conformance pack. Each tag consists of a key
    /// and an optional value, both of which you define.
    tags: ?[]const Tag = null,

    /// A string that contains the full conformance pack template body. Structure
    /// containing the template body
    /// with a minimum length of 1 byte and a maximum length of 51,200 bytes.
    template_body: ?[]const u8 = null,

    /// Location of file containing the template body. The uri must point to the
    /// conformance pack template
    /// (max size: 300 KB).
    ///
    /// You must have access to read Amazon S3 bucket.
    /// In addition, in order to ensure a successful deployment, the template object
    /// must not be in an [archived storage
    /// class](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html) if this parameter is passed.
    template_s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_input_parameters = "ConformancePackInputParameters",
        .delivery_s3_bucket = "DeliveryS3Bucket",
        .delivery_s3_key_prefix = "DeliveryS3KeyPrefix",
        .excluded_accounts = "ExcludedAccounts",
        .organization_conformance_pack_name = "OrganizationConformancePackName",
        .tags = "Tags",
        .template_body = "TemplateBody",
        .template_s3_uri = "TemplateS3Uri",
    };
};

pub const PutOrganizationConformancePackOutput = struct {
    /// ARN of the organization conformance pack.
    organization_conformance_pack_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .organization_conformance_pack_arn = "OrganizationConformancePackArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutOrganizationConformancePackInput, options: CallOptions) !PutOrganizationConformancePackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutOrganizationConformancePackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutOrganizationConformancePack");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutOrganizationConformancePackOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutOrganizationConformancePackOutput, body, allocator);
}
