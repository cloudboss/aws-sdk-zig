const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ControlBehavior = @import("control_behavior.zig").ControlBehavior;
const ImplementationDetails = @import("implementation_details.zig").ImplementationDetails;
const ControlParameter = @import("control_parameter.zig").ControlParameter;
const RegionConfiguration = @import("region_configuration.zig").RegionConfiguration;
const ControlSeverity = @import("control_severity.zig").ControlSeverity;

pub const GetControlInput = struct {
    /// The Amazon Resource Name (ARN) of the control. It has one of the following
    /// formats:
    ///
    /// *Global format*
    ///
    /// `arn:{PARTITION}:controlcatalog:::control/{CONTROL_CATALOG_OPAQUE_ID}`
    ///
    /// *Or Regional format*
    ///
    /// `arn:{PARTITION}:controltower:{REGION}::control/{CONTROL_TOWER_OPAQUE_ID}`
    ///
    /// Here is a more general pattern that covers Amazon Web Services Control Tower
    /// and Control Catalog ARNs:
    ///
    /// `^arn:(aws(?:[-a-z]*)?):(controlcatalog|controltower):[a-zA-Z0-9-]*::control/[0-9a-zA-Z_\\-]+$`
    control_arn: []const u8,

    pub const json_field_names = .{
        .control_arn = "ControlArn",
    };
};

pub const GetControlOutput = struct {
    /// A list of alternative identifiers for the control. These are human-readable
    /// designators, such as `SH.S3.1`. Several aliases can refer to the same
    /// control across different Amazon Web Services services or compliance
    /// frameworks.
    aliases: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the control.
    arn: []const u8,

    /// A term that identifies the control's functional behavior. One of
    /// `Preventive`, `Detective`, `Proactive`
    behavior: ControlBehavior,

    /// A timestamp that notes the time when the control was released (start of its
    /// life) as a governance capability in Amazon Web Services.
    create_time: ?i64 = null,

    /// A description of what the control does.
    description: []const u8,

    /// A list of Amazon Web Services resource types that are governed by this
    /// control. This information helps you understand which controls can govern
    /// certain types of resources, and conversely, which resources are affected
    /// when the control is implemented. The resources are represented as Amazon Web
    /// Services CloudFormation resource types. If `GovernedResources` cannot be
    /// represented by available CloudFormation resource types, it’s returned as an
    /// empty list.
    governed_resources: ?[]const []const u8 = null,

    /// Returns information about the control, as an `ImplementationDetails` object
    /// that shows the underlying implementation type for a control.
    implementation: ?ImplementationDetails = null,

    /// The display name of the control.
    name: []const u8,

    /// Returns an array of `ControlParameter` objects that specify the parameters a
    /// control supports. An empty list is returned for controls that don’t support
    /// parameters.
    parameters: ?[]const ControlParameter = null,

    region_configuration: ?RegionConfiguration = null,

    /// An enumerated type, with the following possible values:
    severity: ?ControlSeverity = null,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .arn = "Arn",
        .behavior = "Behavior",
        .create_time = "CreateTime",
        .description = "Description",
        .governed_resources = "GovernedResources",
        .implementation = "Implementation",
        .name = "Name",
        .parameters = "Parameters",
        .region_configuration = "RegionConfiguration",
        .severity = "Severity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetControlInput, options: CallOptions) !GetControlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "controlcatalog");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlcatalog", "ControlCatalog", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/get-control";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ControlArn\":");
    try aws.json.writeValue(@TypeOf(input.control_arn), input.control_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetControlOutput {
    var result: GetControlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetControlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
