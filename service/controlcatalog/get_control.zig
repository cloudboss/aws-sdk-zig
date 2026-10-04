const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlBehavior = @import("control_behavior.zig").ControlBehavior;
const ImplementationDetails = @import("implementation_details.zig").ImplementationDetails;
const ParameterRequirementSummary = @import("parameter_requirement_summary.zig").ParameterRequirementSummary;
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

    /// A list of providers whose resources are governed by this control. For
    /// example, a value of `AWS` indicates that the control governs Amazon Web
    /// Services resources.
    governed_providers: ?[]const []const u8 = null,

    /// A list of resource types that are governed by this control. This information
    /// helps you understand which controls can govern certain types of resources,
    /// and conversely, which resources are affected when the control is
    /// implemented. For Amazon Web Services controls, the resources are represented
    /// as CloudFormation resource types. For non-Amazon Web Services controls, the
    /// resources are represented in a provider-specific format. If
    /// `GovernedResources` cannot be represented by available resource types, it’s
    /// returned as an empty list.
    governed_resources: ?[]const []const u8 = null,

    /// Returns information about the control, as an `ImplementationDetails` object
    /// that shows the underlying implementation type for a control.
    implementation: ?ImplementationDetails = null,

    /// The display name of the control.
    name: []const u8,

    /// A summary that indicates whether the control requires parameters, accepts
    /// optional parameters, or does not support parameters. Use this field to
    /// determine whether you need to supply parameter values when you enable the
    /// control.
    parameter_requirement_summary: ?ParameterRequirementSummary = null,

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
        .governed_providers = "GovernedProviders",
        .governed_resources = "GovernedResources",
        .implementation = "Implementation",
        .name = "Name",
        .parameter_requirement_summary = "ParameterRequirementSummary",
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "controlcatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlcatalog", "ControlCatalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-control";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ControlArn\":");
    try aws.json.writeValue(@TypeOf(input.control_arn), input.control_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetControlOutput {
    const result: GetControlOutput = try aws.json.parseJsonObject(
        GetControlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
