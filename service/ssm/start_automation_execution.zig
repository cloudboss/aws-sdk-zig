const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const Tag = @import("tag.zig").Tag;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;

pub const StartAutomationExecutionInput = struct {
    /// The CloudWatch alarm you want to apply to your automation.
    alarm_configuration: ?AlarmConfiguration = null,

    /// User-provided idempotency token. The token must be unique, is case
    /// insensitive, enforces the
    /// UUID format, and can't be reused.
    client_token: ?[]const u8 = null,

    /// The name of the SSM document to run. This can be a public document or a
    /// custom document. To
    /// run a shared document belonging to another account, specify the document
    /// ARN. For more
    /// information about how to use shared documents, see [Sharing SSM
    /// documents](https://docs.aws.amazon.com/systems-manager/latest/userguide/documents-ssm-sharing.html)
    /// in the *Amazon Web Services Systems Manager User Guide*.
    document_name: []const u8,

    /// The version of the Automation runbook to use for this execution.
    document_version: ?[]const u8 = null,

    /// The maximum number of targets allowed to run this task in parallel. You can
    /// specify a
    /// number, such as 10, or a percentage, such as 10%. The default value is `10`.
    ///
    /// If both this parameter and the `TargetLocation:TargetsMaxConcurrency` are
    /// supplied, `TargetLocation:TargetsMaxConcurrency` takes precedence.
    max_concurrency: ?[]const u8 = null,

    /// The number of errors that are allowed before the system stops running the
    /// automation on
    /// additional targets. You can specify either an absolute number of errors, for
    /// example 10, or a
    /// percentage of the target set, for example 10%. If you specify 3, for
    /// example, the system stops
    /// running the automation when the fourth error is received. If you specify 0,
    /// then the system stops
    /// running the automation on additional targets after the first error result is
    /// returned. If you run
    /// an automation on 50 resources and set max-errors to 10%, then the system
    /// stops running the
    /// automation on additional targets when the sixth error is received.
    ///
    /// Executions that are already running an automation when max-errors is reached
    /// are allowed to
    /// complete, but some of these executions may fail as well. If you need to
    /// ensure that there won't
    /// be more than max-errors failed executions, set max-concurrency to 1 so the
    /// executions proceed one
    /// at a time.
    ///
    /// If this parameter and the `TargetLocation:TargetsMaxErrors` parameter are
    /// both
    /// supplied, `TargetLocation:TargetsMaxErrors` takes precedence.
    max_errors: ?[]const u8 = null,

    /// The execution mode of the automation. Valid modes include the following:
    /// Auto and
    /// Interactive. The default mode is Auto.
    mode: ?ExecutionMode = null,

    /// A key-value map of execution parameters, which match the declared parameters
    /// in the
    /// Automation runbook.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Optional metadata that you assign to a resource. You can specify a maximum
    /// of five tags for
    /// an automation. Tags enable you to categorize a resource in different ways,
    /// such as by purpose,
    /// owner, or environment. For example, you might want to tag an automation to
    /// identify an
    /// environment or operating system. In this case, you could specify the
    /// following key-value
    /// pairs:
    ///
    /// * `Key=environment,Value=test`
    ///
    /// * `Key=OS,Value=Windows`
    ///
    /// The `Array Members` maximum value is reported as 1000. This number includes
    /// capacity reserved for internal operations. When calling the
    /// `StartAutomationExecution` action, you can specify a maximum of 5 tags. You
    /// can,
    /// however, use the AddTagsToResource action to add up to a total of 50 tags to
    /// an existing automation configuration.
    tags: ?[]const Tag = null,

    /// A location is a combination of Amazon Web Services Regions and/or Amazon Web
    /// Services accounts where you want to run the
    /// automation. Use this operation to start an automation in multiple Amazon Web
    /// Services Regions and multiple
    /// Amazon Web Services accounts. For more information, see [Running automations
    /// in multiple Amazon Web Services Regions and
    /// accounts](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation-multiple-accounts-and-regions.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    target_locations: ?[]const TargetLocation = null,

    /// Specify a publicly accessible URL for a file that contains the
    /// `TargetLocations`
    /// body. Currently, only files in presigned Amazon S3 buckets are supported.
    target_locations_url: ?[]const u8 = null,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8) = null,

    /// The name of the parameter used as the target resource for the
    /// rate-controlled execution.
    /// Required if you specify targets.
    target_parameter_name: ?[]const u8 = null,

    /// A key-value mapping to target resources. Required if you specify
    /// TargetParameterName.
    ///
    /// If both this parameter and the `TargetLocation:Targets` parameter are
    /// supplied,
    /// `TargetLocation:Targets` takes precedence.
    targets: ?[]const Target = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .client_token = "ClientToken",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .mode = "Mode",
        .parameters = "Parameters",
        .tags = "Tags",
        .target_locations = "TargetLocations",
        .target_locations_url = "TargetLocationsURL",
        .target_maps = "TargetMaps",
        .target_parameter_name = "TargetParameterName",
        .targets = "Targets",
    };
};

pub const StartAutomationExecutionOutput = struct {
    /// The unique ID of a newly scheduled automation execution.
    automation_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .automation_execution_id = "AutomationExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAutomationExecutionInput, options: CallOptions) !StartAutomationExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAutomationExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.StartAutomationExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAutomationExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartAutomationExecutionOutput, body, allocator);
}
