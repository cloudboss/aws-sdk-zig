const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ImportModelInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend permission to use Amazon Key Management Service
    /// (KMS) to encrypt or decrypt the custom
    /// model.
    data_access_role_arn: ?[]const u8 = null,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt
    /// trained custom models. The ModelKmsKeyId can be either of the following
    /// formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    model_kms_key_id: ?[]const u8 = null,

    /// The name to assign to the custom model that is created in Amazon Comprehend
    /// by this
    /// import.
    model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the custom model to import.
    source_model_arn: []const u8,

    /// Tags to associate with the custom model that is created by this import. A
    /// tag is a
    /// key-value pair that adds as a metadata to a resource used by Amazon
    /// Comprehend. For example, a
    /// tag with "Sales" as the key might be added to a resource to indicate its use
    /// by the sales
    /// department.
    tags: ?[]const Tag = null,

    /// The version name given to the custom model that is created by this import.
    /// Version names
    /// can have a maximum of 256 characters. Alphanumeric characters, hyphens (-)
    /// and underscores (_)
    /// are allowed. The version name must be unique among all models with the same
    /// classifier name in
    /// the account/Region.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .model_kms_key_id = "ModelKmsKeyId",
        .model_name = "ModelName",
        .source_model_arn = "SourceModelArn",
        .tags = "Tags",
        .version_name = "VersionName",
    };
};

pub const ImportModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the custom model being imported.
    model_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_arn = "ModelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportModelInput, options: CallOptions) !ImportModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.ImportModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportModelOutput, body, allocator);
}
