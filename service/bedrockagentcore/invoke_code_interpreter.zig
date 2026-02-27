const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ToolArguments = @import("tool_arguments.zig").ToolArguments;
const ToolName = @import("tool_name.zig").ToolName;
const CodeInterpreterStreamOutput = @import("code_interpreter_stream_output.zig").CodeInterpreterStreamOutput;

pub const InvokeCodeInterpreterInput = struct {
    /// The arguments for the code interpreter. This includes the code to execute
    /// and any additional parameters such as the programming language, whether to
    /// clear the execution context, and other execution options. The structure of
    /// this parameter depends on the specific code interpreter being used.
    arguments: ?ToolArguments = null,

    /// The unique identifier of the code interpreter associated with the session.
    /// This must match the identifier used when creating the session with
    /// `StartCodeInterpreterSession`.
    code_interpreter_identifier: []const u8,

    /// The name of the code interpreter to invoke.
    name: ToolName,

    /// The unique identifier of the code interpreter session to use. This must be
    /// an active session created with `StartCodeInterpreterSession`. If the session
    /// has expired or been stopped, the request will fail.
    session_id: ?[]const u8 = null,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    pub const json_field_names = .{
        .arguments = "arguments",
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .name = "name",
        .session_id = "sessionId",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
    };
};

pub const InvokeCodeInterpreterOutput = struct {
    /// The identifier of the code interpreter session.
    session_id: ?[]const u8 = null,

    /// The stream containing the results of the code execution. This includes
    /// output, errors, and execution status.
    stream: ?CodeInterpreterStreamOutput = null,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream = "stream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeCodeInterpreterInput, options: Options) !InvokeCodeInterpreterOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
