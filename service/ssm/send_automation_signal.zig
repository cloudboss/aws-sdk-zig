const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SignalType = @import("signal_type.zig").SignalType;

pub const SendAutomationSignalInput = struct {
    /// The unique identifier for an existing Automation execution that you want to
    /// send the signal
    /// to.
    automation_execution_id: []const u8,

    /// The data sent with the signal. The data schema depends on the type of signal
    /// used in the
    /// request.
    ///
    /// For `Approve` and `Reject` signal types, the payload is an optional
    /// comment that you can send with the signal type. For example:
    ///
    /// `Comment="Looks good"`
    ///
    /// For `StartStep` and `Resume` signal types, you must send the name of
    /// the Automation step to start or resume as the payload. For example:
    ///
    /// `StepName="step1"`
    ///
    /// For the `StopStep` signal type, you must send the step execution ID as the
    /// payload. For example:
    ///
    /// `StepExecutionId="97fff367-fc5a-4299-aed8-0123456789ab"`
    payload: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The type of signal to send to an Automation execution.
    signal_type: SignalType,

    pub const json_field_names = .{
        .automation_execution_id = "AutomationExecutionId",
        .payload = "Payload",
        .signal_type = "SignalType",
    };
};

pub const SendAutomationSignalOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendAutomationSignalInput, options: CallOptions) !SendAutomationSignalOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendAutomationSignalInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.SendAutomationSignal");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendAutomationSignalOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
