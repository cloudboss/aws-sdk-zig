const aws = @import("aws");
const std = @import("std");

const get_raw_message_content = @import("get_raw_message_content.zig");
const put_raw_message_content = @import("put_raw_message_content.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WorkMailMessageFlow";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Retrieves the raw content of an in-transit email message, in MIME format.
    pub fn getRawMessageContent(self: *Self, allocator: std.mem.Allocator, input: get_raw_message_content.GetRawMessageContentInput, options: CallOptions) !get_raw_message_content.GetRawMessageContentOutput {
        return get_raw_message_content.execute(self, allocator, input, options);
    }

    /// Updates the raw content of an in-transit email message, in MIME format.
    ///
    /// This example describes how to update in-transit email message. For more
    /// information and examples for using this API, see
    /// [
    /// Updating message content with AWS
    /// Lambda](https://docs.aws.amazon.com/workmail/latest/adminguide/update-with-lambda.html).
    ///
    /// Updates to an in-transit message only appear when you call
    /// `PutRawMessageContent` from an AWS Lambda function
    /// configured with a synchronous [
    /// Run
    /// Lambda](https://docs.aws.amazon.com/workmail/latest/adminguide/lambda.html#synchronous-rules) rule. If you call `PutRawMessageContent` on a delivered or sent message, the message remains unchanged,
    /// even though
    /// [GetRawMessageContent](https://docs.aws.amazon.com/workmail/latest/APIReference/API_messageflow_GetRawMessageContent.html) returns an updated
    /// message.
    pub fn putRawMessageContent(self: *Self, allocator: std.mem.Allocator, input: put_raw_message_content.PutRawMessageContentInput, options: CallOptions) !put_raw_message_content.PutRawMessageContentOutput {
        return put_raw_message_content.execute(self, allocator, input, options);
    }
};
