const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConstraintSummary = @import("constraint_summary.zig").ConstraintSummary;
const ProvisioningArtifactOutput = @import("provisioning_artifact_output.zig").ProvisioningArtifactOutput;
const ProvisioningArtifactParameter = @import("provisioning_artifact_parameter.zig").ProvisioningArtifactParameter;
const ProvisioningArtifactPreferences = @import("provisioning_artifact_preferences.zig").ProvisioningArtifactPreferences;
const TagOptionSummary = @import("tag_option_summary.zig").TagOptionSummary;
const UsageInstruction = @import("usage_instruction.zig").UsageInstruction;

pub const DescribeProvisioningParametersInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The path identifier of the product. This value is optional if the product
    /// has a default path, and required if the product has more than one path.
    /// To list the paths for a product, use ListLaunchPaths. You must provide the
    /// name or ID, but not both.
    path_id: ?[]const u8 = null,

    /// The name of the path. You must provide the name or ID, but not both.
    path_name: ?[]const u8 = null,

    /// The product identifier. You must provide the product name or ID, but not
    /// both.
    product_id: ?[]const u8 = null,

    /// The name of the product. You must provide the name or ID, but not both.
    product_name: ?[]const u8 = null,

    /// The identifier of the provisioning artifact. You must provide the name or
    /// ID, but not both.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The name of the provisioning artifact. You must provide the name or ID, but
    /// not both.
    provisioning_artifact_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .path_id = "PathId",
        .path_name = "PathName",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_artifact_name = "ProvisioningArtifactName",
    };
};

pub const DescribeProvisioningParametersOutput = struct {
    /// Information about the constraints used to provision the product.
    constraint_summaries: ?[]const ConstraintSummary = null,

    /// A list of the keys and descriptions of the outputs. These outputs can be
    /// referenced from a provisioned product launched from this provisioning
    /// artifact.
    provisioning_artifact_output_keys: ?[]const ProvisioningArtifactOutput = null,

    /// The output of the provisioning artifact.
    provisioning_artifact_outputs: ?[]const ProvisioningArtifactOutput = null,

    /// Information about the parameters used to provision the product.
    provisioning_artifact_parameters: ?[]const ProvisioningArtifactParameter = null,

    /// An object that contains information about preferences, such as Regions and
    /// accounts, for the provisioning artifact.
    provisioning_artifact_preferences: ?ProvisioningArtifactPreferences = null,

    /// Information about the TagOptions associated with the resource.
    tag_options: ?[]const TagOptionSummary = null,

    /// Any additional metadata specifically related to the provisioning of the
    /// product. For
    /// example, see the `Version` field of the CloudFormation template.
    usage_instructions: ?[]const UsageInstruction = null,

    pub const json_field_names = .{
        .constraint_summaries = "ConstraintSummaries",
        .provisioning_artifact_output_keys = "ProvisioningArtifactOutputKeys",
        .provisioning_artifact_outputs = "ProvisioningArtifactOutputs",
        .provisioning_artifact_parameters = "ProvisioningArtifactParameters",
        .provisioning_artifact_preferences = "ProvisioningArtifactPreferences",
        .tag_options = "TagOptions",
        .usage_instructions = "UsageInstructions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProvisioningParametersInput, options: CallOptions) !DescribeProvisioningParametersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicecatalog");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProvisioningParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribeProvisioningParameters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProvisioningParametersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProvisioningParametersOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "DuplicateResourceException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParametersException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameters_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagOptionNotMigratedException")) {
        return .{ .arena = arena, .kind = .{ .tag_option_not_migrated_exception = .{
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
