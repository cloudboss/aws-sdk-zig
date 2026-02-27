const aws = @import("aws");
const std = @import("std");

const invoke_endpoint_with_bidirectional_stream = @import("invoke_endpoint_with_bidirectional_stream.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker Runtime HTTP2";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Invokes a model endpoint with bidirectional streaming capabilities. This
    /// operation establishes a persistent connection that allows you to send
    /// multiple requests and receive streaming responses from the model in
    /// real-time.
    ///
    /// Bidirectional streaming is useful for interactive applications such as
    /// chatbots, real-time translation, or any scenario where you need to maintain
    /// a conversation-like interaction with the model. The connection remains open,
    /// allowing you to send additional input and receive responses without
    /// establishing a new connection for each request.
    ///
    /// For an overview of Amazon SageMaker AI, see [How It
    /// Works](https://docs.aws.amazon.com/sagemaker/latest/dg/how-it-works.html).
    ///
    /// Amazon SageMaker AI strips all POST headers except those supported by the
    /// API. Amazon SageMaker AI might add additional headers. You should not rely
    /// on the behavior of headers outside those enumerated in the request syntax.
    ///
    /// Calls to `InvokeEndpointWithBidirectionalStream` are authenticated by using
    /// Amazon Web Services Signature Version 4. For information, see
    /// [Authenticating Requests (Amazon Web Services Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) in the *Amazon S3 API Reference*.
    ///
    /// The bidirectional stream maintains the connection until either the client
    /// closes it or the model indicates completion. Each request and response in
    /// the stream is sent as an event with optional headers for data type and
    /// completion state.
    ///
    /// Endpoints are scoped to an individual account, and are not public. The URL
    /// does not contain the account ID, but Amazon SageMaker AI determines the
    /// account ID from the authentication token that is supplied by the caller.
    pub fn invokeEndpointWithBidirectionalStream(self: *Self, allocator: std.mem.Allocator, input: invoke_endpoint_with_bidirectional_stream.InvokeEndpointWithBidirectionalStreamInput, options: invoke_endpoint_with_bidirectional_stream.Options) !invoke_endpoint_with_bidirectional_stream.InvokeEndpointWithBidirectionalStreamOutput {
        return invoke_endpoint_with_bidirectional_stream.execute(self, allocator, input, options);
    }
};
