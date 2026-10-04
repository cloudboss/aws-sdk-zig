const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Compatibility = @import("compatibility.zig").Compatibility;
const DataFormat = @import("data_format.zig").DataFormat;
const RegistryId = @import("registry_id.zig").RegistryId;
const SchemaStatus = @import("schema_status.zig").SchemaStatus;
const SchemaVersionStatus = @import("schema_version_status.zig").SchemaVersionStatus;

pub const CreateSchemaInput = struct {
    /// The compatibility mode of the schema. The possible values are:
    ///
    /// * *NONE*: No compatibility mode applies. You can use this choice in
    ///   development scenarios or if you do not know the compatibility mode that
    ///   you want to apply to schemas. Any new version added will be accepted
    ///   without undergoing a compatibility check.
    ///
    /// * *DISABLED*: This compatibility choice prevents versioning for a particular
    ///   schema. You can use this choice to prevent future versioning of a schema.
    ///
    /// * *BACKWARD*: This compatibility choice is recommended as it allows data
    ///   receivers to read both the current and one previous schema version. This
    ///   means that for instance, a new schema version cannot drop data fields or
    ///   change the type of these fields, so they can't be read by readers using
    ///   the previous version.
    ///
    /// * *BACKWARD_ALL*: This compatibility choice allows data receivers to read
    ///   both the current and all previous schema versions. You can use this choice
    ///   when you need to delete fields or add optional fields, and check
    ///   compatibility against all previous schema versions.
    ///
    /// * *FORWARD*: This compatibility choice allows data receivers to read both
    ///   the current and one next schema version, but not necessarily later
    ///   versions. You can use this choice when you need to add fields or delete
    ///   optional fields, but only check compatibility against the last schema
    ///   version.
    ///
    /// * *FORWARD_ALL*: This compatibility choice allows data receivers to read
    ///   written by producers of any new registered schema. You can use this choice
    ///   when you need to add fields or delete optional fields, and check
    ///   compatibility against all previous schema versions.
    ///
    /// * *FULL*: This compatibility choice allows data receivers to read data
    ///   written by producers using the previous or next version of the schema, but
    ///   not necessarily earlier or later versions. You can use this choice when
    ///   you need to add or remove optional fields, but only check compatibility
    ///   against the last schema version.
    ///
    /// * *FULL_ALL*: This compatibility choice allows data receivers to read data
    ///   written by producers using all previous schema versions. You can use this
    ///   choice when you need to add or remove optional fields, and check
    ///   compatibility against all previous schema versions.
    compatibility: ?Compatibility = null,

    /// The data format of the schema definition. Currently `AVRO`, `JSON` and
    /// `PROTOBUF` are supported.
    data_format: DataFormat,

    /// An optional description of the schema. If description is not provided, there
    /// will not be any automatic default value for this.
    description: ?[]const u8 = null,

    /// This is a wrapper shape to contain the registry identity fields. If this is
    /// not provided, the default registry will be used. The ARN format for the same
    /// will be:
    /// `arn:aws:glue:us-east-2::registry/default-registry:random-5-letter-id`.
    registry_id: ?RegistryId = null,

    /// The schema definition using the `DataFormat` setting for `SchemaName`.
    schema_definition: ?[]const u8 = null,

    /// Name of the schema to be created of max length of 255, and may only contain
    /// letters, numbers, hyphen, underscore, dollar sign, or hash mark. No
    /// whitespace.
    schema_name: []const u8,

    /// Amazon Web Services tags that contain a key value pair and may be searched
    /// by console, command line, or API. If specified, follows the Amazon Web
    /// Services tags-on-create pattern.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compatibility = "Compatibility",
        .data_format = "DataFormat",
        .description = "Description",
        .registry_id = "RegistryId",
        .schema_definition = "SchemaDefinition",
        .schema_name = "SchemaName",
        .tags = "Tags",
    };
};

pub const CreateSchemaOutput = struct {
    /// The schema compatibility mode.
    compatibility: ?Compatibility = null,

    /// The data format of the schema definition. Currently `AVRO`, `JSON` and
    /// `PROTOBUF` are supported.
    data_format: ?DataFormat = null,

    /// A description of the schema if specified when created.
    description: ?[]const u8 = null,

    /// The latest version of the schema associated with the returned schema
    /// definition.
    latest_schema_version: ?i64 = null,

    /// The next version of the schema associated with the returned schema
    /// definition.
    next_schema_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: ?[]const u8 = null,

    /// The name of the registry.
    registry_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8 = null,

    /// The version number of the checkpoint (the last time the compatibility mode
    /// was changed).
    schema_checkpoint: ?i64 = null,

    /// The name of the schema.
    schema_name: ?[]const u8 = null,

    /// The status of the schema.
    schema_status: ?SchemaStatus = null,

    /// The unique identifier of the first schema version.
    schema_version_id: ?[]const u8 = null,

    /// The status of the first schema version created.
    schema_version_status: ?SchemaVersionStatus = null,

    /// The tags for the schema.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compatibility = "Compatibility",
        .data_format = "DataFormat",
        .description = "Description",
        .latest_schema_version = "LatestSchemaVersion",
        .next_schema_version = "NextSchemaVersion",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_checkpoint = "SchemaCheckpoint",
        .schema_name = "SchemaName",
        .schema_status = "SchemaStatus",
        .schema_version_id = "SchemaVersionId",
        .schema_version_status = "SchemaVersionStatus",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSchemaInput, options: CallOptions) !CreateSchemaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateSchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSchemaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSchemaOutput, body, allocator);
}
