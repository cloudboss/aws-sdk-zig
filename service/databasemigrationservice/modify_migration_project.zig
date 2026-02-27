const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SCApplicationAttributes = @import("sc_application_attributes.zig").SCApplicationAttributes;
const DataProviderDescriptorDefinition = @import("data_provider_descriptor_definition.zig").DataProviderDescriptorDefinition;
const MigrationProject = @import("migration_project.zig").MigrationProject;

pub const ModifyMigrationProjectInput = struct {
    /// A user-friendly description of the migration project.
    description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) for the instance profile.
    instance_profile_identifier: ?[]const u8 = null,

    /// The identifier of the migration project. Identifiers must begin with a
    /// letter
    /// and must contain only ASCII letters, digits, and hyphens. They can't end
    /// with
    /// a hyphen, or contain two consecutive hyphens.
    migration_project_identifier: []const u8,

    /// A user-friendly name for the migration project.
    migration_project_name: ?[]const u8 = null,

    /// The schema conversion application attributes, including the Amazon S3 bucket
    /// name and Amazon S3 role ARN.
    schema_conversion_application_attributes: ?SCApplicationAttributes = null,

    /// Information about the source data provider, including the name, ARN, and
    /// Amazon Web Services Secrets Manager parameters.
    source_data_provider_descriptors: ?[]const DataProviderDescriptorDefinition = null,

    /// Information about the target data provider, including the name, ARN, and
    /// Amazon Web Services Secrets Manager parameters.
    target_data_provider_descriptors: ?[]const DataProviderDescriptorDefinition = null,

    /// The settings in JSON format for migration rules. Migration rules make it
    /// possible for you to change
    /// the object names according to the rules that you specify. For example, you
    /// can change an object name
    /// to lowercase or uppercase, add or remove a prefix or suffix, or rename
    /// objects.
    transformation_rules: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .instance_profile_identifier = "InstanceProfileIdentifier",
        .migration_project_identifier = "MigrationProjectIdentifier",
        .migration_project_name = "MigrationProjectName",
        .schema_conversion_application_attributes = "SchemaConversionApplicationAttributes",
        .source_data_provider_descriptors = "SourceDataProviderDescriptors",
        .target_data_provider_descriptors = "TargetDataProviderDescriptors",
        .transformation_rules = "TransformationRules",
    };
};

pub const ModifyMigrationProjectOutput = struct {
    /// The migration project that was modified.
    migration_project: ?MigrationProject = null,

    pub const json_field_names = .{
        .migration_project = "MigrationProject",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyMigrationProjectInput, options: Options) !ModifyMigrationProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "databasemigrationservice");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyMigrationProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databasemigrationservice", "Database Migration Service", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonDMSv20160101.ModifyMigrationProject");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyMigrationProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyMigrationProjectOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CollectorNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .collector_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyFault")) {
        return .{ .arena = arena, .kind = .{ .failed_dependency_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientResourceCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_resource_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_certificate_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSFault")) {
        return .{ .arena = arena, .kind = .{ .kms_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateFault")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingFault")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationSubnetGroupDoesNotCoverEnoughAZs")) {
        return .{ .arena = arena, .kind = .{ .replication_subnet_group_does_not_cover_enough_a_zs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .s3_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .s3_resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpgradeDependencyFailureFault")) {
        return .{ .arena = arena, .kind = .{ .upgrade_dependency_failure_fault = .{
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
