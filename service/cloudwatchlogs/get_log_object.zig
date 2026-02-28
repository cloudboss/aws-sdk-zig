const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GetLogObjectResponseStream = @import("get_log_object_response_stream.zig").GetLogObjectResponseStream;

pub const GetLogObjectInput = struct {
    /// A pointer to the specific log object to retrieve. This is a required
    /// parameter that
    /// uniquely identifies the log object within CloudWatch Logs. The pointer is
    /// typically obtained
    /// from a previous query or filter operation.
    log_object_pointer: []const u8,

    /// A boolean flag that indicates whether to unmask sensitive log data. When set
    /// to true, any
    /// masked or redacted data in the log object will be displayed in its original
    /// form. Default is
    /// false.
    unmask: ?bool = null,

    pub const json_field_names = .{
        .log_object_pointer = "logObjectPointer",
        .unmask = "unmask",
    };
};

pub const GetLogObjectOutput = struct {
    /// A stream of structured log data returned by the GetLogObject operation. This
    /// stream
    /// contains log events with their associated metadata and extracted fields.
    field_stream: ?GetLogObjectResponseStream = null,

    pub const json_field_names = .{
        .field_stream = "fieldStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLogObjectInput, options: Options) !GetLogObjectOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
