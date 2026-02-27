const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RetrieveAndGenerateInput = @import("retrieve_and_generate_input.zig").RetrieveAndGenerateInput;
const RetrieveAndGenerateConfiguration = @import("retrieve_and_generate_configuration.zig").RetrieveAndGenerateConfiguration;
const RetrieveAndGenerateSessionConfiguration = @import("retrieve_and_generate_session_configuration.zig").RetrieveAndGenerateSessionConfiguration;
const RetrieveAndGenerateStreamResponseOutput = @import("retrieve_and_generate_stream_response_output.zig").RetrieveAndGenerateStreamResponseOutput;

pub const RetrieveAndGenerateStreamInput = struct {
    /// Contains the query to be made to the knowledge base.
    input: RetrieveAndGenerateInput,

    /// Contains configurations for the knowledge base query and retrieval process.
    /// For more information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    retrieve_and_generate_configuration: ?RetrieveAndGenerateConfiguration = null,

    /// Contains details about the session with the knowledge base.
    session_configuration: ?RetrieveAndGenerateSessionConfiguration = null,

    /// The unique identifier of the session. When you first make a
    /// `RetrieveAndGenerate` request, Amazon Bedrock automatically generates this
    /// value. You must reuse this value for all subsequent requests in the same
    /// conversational session. This value allows Amazon Bedrock to maintain context
    /// and knowledge from previous interactions. You can't explicitly set the
    /// `sessionId` yourself.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .input = "input",
        .retrieve_and_generate_configuration = "retrieveAndGenerateConfiguration",
        .session_configuration = "sessionConfiguration",
        .session_id = "sessionId",
    };
};

pub const RetrieveAndGenerateStreamOutput = struct {
    /// The session ID.
    session_id: []const u8,

    /// A stream of events from the model.
    stream: ?RetrieveAndGenerateStreamResponseOutput = null,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream = "stream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveAndGenerateStreamInput, options: Options) !RetrieveAndGenerateStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
