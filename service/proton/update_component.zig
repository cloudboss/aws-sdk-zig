const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ComponentDeploymentUpdateType = @import("component_deployment_update_type.zig").ComponentDeploymentUpdateType;
const Component = @import("component.zig").Component;

pub const UpdateComponentInput = struct {
    /// The client token for the updated component.
    client_token: ?[]const u8 = null,

    /// The deployment type. It defines the mode for updating a component, as
    /// follows:
    ///
    /// `NONE`
    ///
    /// In this mode, a deployment *doesn't* occur. Only the requested metadata
    /// parameters are updated. You can only specify
    /// `description` in this mode.
    ///
    /// `CURRENT_VERSION`
    ///
    /// In this mode, the component is deployed and updated with the new
    /// `serviceSpec`, `templateSource`, and/or `type`
    /// that you provide. Only requested parameters are updated.
    deployment_type: ComponentDeploymentUpdateType,

    /// An optional customer-provided description of the component.
    description: ?[]const u8 = null,

    /// The name of the component to update.
    name: []const u8,

    /// The name of the service instance that you want to attach this component to.
    /// Don't specify to keep the component's current service instance attachment.
    /// Specify an empty string to detach the component from the service instance
    /// it's attached to. Specify non-empty values for both
    /// `serviceInstanceName` and `serviceName` or for neither of them.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service that `serviceInstanceName` is associated with. Don't
    /// specify to keep the component's current service instance
    /// attachment. Specify an empty string to detach the component from the service
    /// instance it's attached to. Specify non-empty values for both
    /// `serviceInstanceName` and `serviceName` or for neither of them.
    service_name: ?[]const u8 = null,

    /// The service spec that you want the component to use to access service
    /// inputs. Set this only when the component is attached to a service
    /// instance.
    service_spec: ?[]const u8 = null,

    /// A path to the Infrastructure as Code (IaC) file describing infrastructure
    /// that a custom component provisions.
    ///
    /// Components support a single IaC file, even if you use Terraform as your
    /// template language.
    template_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .deployment_type = "deploymentType",
        .description = "description",
        .name = "name",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .service_spec = "serviceSpec",
        .template_file = "templateFile",
    };
};

pub const UpdateComponentOutput = struct {
    /// The detailed data of the updated component.
    component: ?Component = null,

    pub const json_field_names = .{
        .component = "component",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComponentInput, options: Options) !UpdateComponentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "proton");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComponentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateComponentOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
