const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StartLiveTailResponseStream = @import("start_live_tail_response_stream.zig").StartLiveTailResponseStream;

pub const StartLiveTailInput = struct {
    /// An optional pattern to use to filter the results to include only log events
    /// that match the
    /// pattern. For example, a filter pattern of `error 404` causes only log events
    /// that
    /// include both `error` and `404` to be included in the Live Tail
    /// stream.
    ///
    /// Regular expression filter patterns are supported.
    ///
    /// For more information about filter pattern syntax, see [Filter and Pattern
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).
    log_event_filter_pattern: ?[]const u8 = null,

    /// An array where each item in the array is a log group to include in the Live
    /// Tail
    /// session.
    ///
    /// Specify each log group by its ARN.
    ///
    /// If you specify an ARN, the ARN can't end with an asterisk (*).
    ///
    /// You can include up to 10 log groups.
    log_group_identifiers: []const []const u8,

    /// If you specify this parameter, then only log events in the log streams that
    /// have names
    /// that start with the prefixes that you specify here are included in the Live
    /// Tail
    /// session.
    ///
    /// If you specify this field, you can't also specify the `logStreamNames`
    /// field.
    ///
    /// You can specify this parameter only if you specify only one log group in
    /// `logGroupIdentifiers`.
    log_stream_name_prefixes: ?[]const []const u8 = null,

    /// If you specify this parameter, then only log events in the log streams that
    /// you specify
    /// here are included in the Live Tail session.
    ///
    /// If you specify this field, you can't also specify the
    /// `logStreamNamePrefixes`
    /// field.
    ///
    /// You can specify this parameter only if you specify only one log group in
    /// `logGroupIdentifiers`.
    log_stream_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .log_event_filter_pattern = "logEventFilterPattern",
        .log_group_identifiers = "logGroupIdentifiers",
        .log_stream_name_prefixes = "logStreamNamePrefixes",
        .log_stream_names = "logStreamNames",
    };
};

pub const StartLiveTailOutput = struct {
    /// An object that includes the stream returned by your request. It can include
    /// both log
    /// events and exceptions.
    response_stream: ?StartLiveTailResponseStream = null,

    pub const json_field_names = .{
        .response_stream = "responseStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartLiveTailInput, options: Options) !StartLiveTailOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
