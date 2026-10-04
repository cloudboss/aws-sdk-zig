const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SCApplicationAttributes = @import("sc_application_attributes.zig").SCApplicationAttributes;
const DataProviderDescriptorDefinition = @import("data_provider_descriptor_definition.zig").DataProviderDescriptorDefinition;
const Tag = @import("tag.zig").Tag;
const MigrationProject = @import("migration_project.zig").MigrationProject;

pub const CreateMigrationProjectInput = struct {
    /// A user-friendly description of the migration project.
    description: ?[]const u8 = null,

    /// The identifier of the associated instance profile. Identifiers must begin
    /// with a letter
    /// and must contain only ASCII letters, digits, and hyphens. They can't end
    /// with
    /// a hyphen, or contain two consecutive hyphens.
    instance_profile_identifier: []const u8,

    /// A user-friendly name for the migration project.
    migration_project_name: ?[]const u8 = null,

    /// The schema conversion application attributes, including the Amazon S3 bucket
    /// name and Amazon S3 role ARN.
    schema_conversion_application_attributes: ?SCApplicationAttributes = null,

    /// Information about the source data provider, including the name, ARN, and
    /// Secrets Manager parameters.
    source_data_provider_descriptors: []const DataProviderDescriptorDefinition,

    /// One or more tags to be assigned to the migration project.
    tags: ?[]const Tag = null,

    /// Information about the target data provider, including the name, ARN, and
    /// Amazon Web Services Secrets Manager parameters.
    target_data_provider_descriptors: []const DataProviderDescriptorDefinition,

    /// A JSON string that specifies the transformation rules for the migration
    /// project.
    /// Transformation rules let you customize how DMS Schema Conversion converts
    /// your source
    /// database objects, including renaming, adding prefixes or suffixes, and
    /// changing data types.
    /// For the transformation rule format and examples, see [Transformation rules
    /// in DMS
    /// Schema
    /// Conversion](https://docs.aws.amazon.com/dms/latest/userguide/sc-transformation-rules.html).
    ///
    /// Homogeneous data migrations do not support transformation rules.
    transformation_rules: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .instance_profile_identifier = "InstanceProfileIdentifier",
        .migration_project_name = "MigrationProjectName",
        .schema_conversion_application_attributes = "SchemaConversionApplicationAttributes",
        .source_data_provider_descriptors = "SourceDataProviderDescriptors",
        .tags = "Tags",
        .target_data_provider_descriptors = "TargetDataProviderDescriptors",
        .transformation_rules = "TransformationRules",
    };
};

pub const CreateMigrationProjectOutput = struct {
    /// The migration project that was created.
    migration_project: ?MigrationProject = null,

    pub const json_field_names = .{
        .migration_project = "MigrationProject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMigrationProjectInput, options: CallOptions) !CreateMigrationProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMigrationProjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateMigrationProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMigrationProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMigrationProjectOutput, body, allocator);
}
