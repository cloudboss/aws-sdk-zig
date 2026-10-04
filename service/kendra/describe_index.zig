const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;
const DocumentMetadataConfiguration = @import("document_metadata_configuration.zig").DocumentMetadataConfiguration;
const IndexEdition = @import("index_edition.zig").IndexEdition;
const IndexStatistics = @import("index_statistics.zig").IndexStatistics;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const IndexStatus = @import("index_status.zig").IndexStatus;
const UserContextPolicy = @import("user_context_policy.zig").UserContextPolicy;
const UserGroupResolutionConfiguration = @import("user_group_resolution_configuration.zig").UserGroupResolutionConfiguration;
const UserTokenConfiguration = @import("user_token_configuration.zig").UserTokenConfiguration;

pub const DescribeIndexInput = struct {
    /// The identifier of the index you want to get information on.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const DescribeIndexOutput = struct {
    /// For Enterprise Edition indexes, you can choose to use additional capacity to
    /// meet the
    /// needs of your application. This contains the capacity units used for the
    /// index. A query or
    /// document storage capacity of zero indicates that the index is using the
    /// default capacity. For
    /// more information on the default capacity for an index and adjusting this,
    /// see [Adjusting
    /// capacity](https://docs.aws.amazon.com/kendra/latest/dg/adjusting-capacity.html).
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// The Unix timestamp when the index was created.
    created_at: ?i64 = null,

    /// The description for the index.
    description: ?[]const u8 = null,

    /// Configuration information for document metadata or fields. Document metadata
    /// are fields or
    /// attributes associated with your documents. For example, the company
    /// department name associated
    /// with each document.
    document_metadata_configurations: ?[]const DocumentMetadataConfiguration = null,

    /// The Amazon Kendra edition used for the index. You decide the edition when
    /// you create
    /// the index.
    edition: ?IndexEdition = null,

    /// When the `Status` field value is `FAILED`, the
    /// `ErrorMessage` field contains a message that explains why.
    error_message: ?[]const u8 = null,

    /// The identifier of the index.
    id: ?[]const u8 = null,

    /// Provides information about the number of FAQ questions and answers and the
    /// number of text
    /// documents indexed.
    index_statistics: ?IndexStatistics = null,

    /// The name of the index.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that gives Amazon Kendra
    /// permission to write to your Amazon CloudWatch logs.
    role_arn: ?[]const u8 = null,

    /// The identifier of the KMS customer master key (CMK) that is used to encrypt
    /// your data. Amazon Kendra doesn't support asymmetric CMKs.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The current status of the index. When the value is `ACTIVE`, the index is
    /// ready
    /// for use. If the `Status` field value is `FAILED`, the
    /// `ErrorMessage` field contains a message that explains why.
    status: ?IndexStatus = null,

    /// The Unix timestamp when the index was last updated.
    updated_at: ?i64 = null,

    /// The user context policy for the Amazon Kendra index.
    user_context_policy: ?UserContextPolicy = null,

    /// Whether you have enabled IAM Identity Center identity source for your users
    /// and
    /// groups. This is useful for user context filtering, where search results are
    /// filtered based
    /// on the user or their group access to documents.
    user_group_resolution_configuration: ?UserGroupResolutionConfiguration = null,

    /// The user token configuration for the Amazon Kendra index.
    user_token_configurations: ?[]const UserTokenConfiguration = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .created_at = "CreatedAt",
        .description = "Description",
        .document_metadata_configurations = "DocumentMetadataConfigurations",
        .edition = "Edition",
        .error_message = "ErrorMessage",
        .id = "Id",
        .index_statistics = "IndexStatistics",
        .name = "Name",
        .role_arn = "RoleArn",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
        .status = "Status",
        .updated_at = "UpdatedAt",
        .user_context_policy = "UserContextPolicy",
        .user_group_resolution_configuration = "UserGroupResolutionConfiguration",
        .user_token_configurations = "UserTokenConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIndexInput, options: CallOptions) !DescribeIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIndexInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeIndex");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIndexOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeIndexOutput, body, allocator);
}
