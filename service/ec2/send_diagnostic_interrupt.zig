const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Sends a diagnostic interrupt to the specified Amazon EC2 instance to trigger
/// a
/// *kernel panic* (on Linux instances), or a *blue
/// screen*/*stop error* (on Windows instances). For
/// instances based on Intel and AMD processors, the interrupt is received as a
/// *non-maskable interrupt* (NMI).
///
/// In general, the operating system crashes and reboots when a kernel panic or
/// stop error
/// is triggered. The operating system can also be configured to perform
/// diagnostic tasks,
/// such as generating a memory dump file, loading a secondary kernel, or
/// obtaining a call
/// trace.
///
/// Before sending a diagnostic interrupt to your instance, ensure that its
/// operating
/// system is configured to perform the required diagnostic tasks.
///
/// For more information about configuring your operating system to generate a
/// crash dump
/// when a kernel panic or stop error occurs, see [Send a diagnostic interrupt
/// (for advanced
/// users)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/diagnostic-interrupt.html) in the *Amazon EC2 User Guide*.
pub const SendDiagnosticInterruptInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance.
    instance_id: []const u8,
};

pub const SendDiagnosticInterruptOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *SendDiagnosticInterruptOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: SendDiagnosticInterruptInput, options: Options) !SendDiagnosticInterruptOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: SendDiagnosticInterruptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=SendDiagnosticInterrupt&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SendDiagnosticInterruptOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: SendDiagnosticInterruptOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
