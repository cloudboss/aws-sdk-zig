const aws = @import("aws");
const std = @import("std");

const invoke_endpoint = @import("invoke_endpoint.zig");
const invoke_endpoint_async = @import("invoke_endpoint_async.zig");
const invoke_endpoint_with_response_stream = @import("invoke_endpoint_with_response_stream.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker Runtime";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// After you deploy a model into production using Amazon SageMaker AI hosting
    /// services,
    /// your client applications use this API to get inferences from the model
    /// hosted at the
    /// specified endpoint.
    ///
    /// For an overview of Amazon SageMaker AI, see [How It
    /// Works](https://docs.aws.amazon.com/sagemaker/latest/dg/how-it-works.html).
    ///
    /// Amazon SageMaker AI strips all POST headers except those supported by the
    /// API. Amazon SageMaker AI might add
    /// additional headers. You should not rely on the behavior of headers outside
    /// those
    /// enumerated in the request syntax.
    ///
    /// Calls to `InvokeEndpoint` are authenticated by using Amazon Web Services
    /// Signature Version 4. For information, see [Authenticating
    /// Requests (Amazon Web Services Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) in the *Amazon S3 API Reference*.
    ///
    /// A customer's model containers must respond to requests within 60 seconds.
    /// The model
    /// itself can have a maximum processing time of 60 seconds before responding to
    /// invocations. If your model is going to take 50-60 seconds of processing
    /// time, the SDK
    /// socket timeout should be set to be 70 seconds.
    ///
    /// Endpoints are scoped to an individual account, and are not public. The URL
    /// does
    /// not contain the account ID, but Amazon SageMaker AI determines the account
    /// ID from
    /// the authentication token that is supplied by the caller.
    pub fn invokeEndpoint(self: *Self, allocator: std.mem.Allocator, input: invoke_endpoint.InvokeEndpointInput, options: invoke_endpoint.Options) !invoke_endpoint.InvokeEndpointOutput {
        return invoke_endpoint.execute(self, allocator, input, options);
    }

    /// After you deploy a model into production using Amazon SageMaker AI hosting
    /// services,
    /// your client applications use this API to get inferences from the model
    /// hosted at the
    /// specified endpoint in an asynchronous manner.
    ///
    /// Inference requests sent to this API are enqueued for asynchronous
    /// processing. The
    /// processing of the inference request may or may not complete before you
    /// receive a
    /// response from this API. The response from this API will not contain the
    /// result of the
    /// inference request but contain information about where you can locate it.
    ///
    /// Amazon SageMaker AI strips all POST headers except those supported by the
    /// API. Amazon SageMaker AI might add
    /// additional headers. You should not rely on the behavior of headers outside
    /// those
    /// enumerated in the request syntax.
    ///
    /// Calls to `InvokeEndpointAsync` are authenticated by using Amazon Web
    /// Services Signature Version 4. For information, see [Authenticating
    /// Requests (Amazon Web Services Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) in the *Amazon S3 API Reference*.
    pub fn invokeEndpointAsync(self: *Self, allocator: std.mem.Allocator, input: invoke_endpoint_async.InvokeEndpointAsyncInput, options: invoke_endpoint_async.Options) !invoke_endpoint_async.InvokeEndpointAsyncOutput {
        return invoke_endpoint_async.execute(self, allocator, input, options);
    }

    /// Invokes a model at the specified endpoint to return the inference response
    /// as a
    /// stream. The inference stream provides the response payload incrementally as
    /// a series of
    /// parts. Before you can get an inference stream, you must have access to a
    /// model that's
    /// deployed using Amazon SageMaker AI hosting services, and the container for
    /// that model
    /// must support inference streaming.
    ///
    /// For more information that can help you use this API, see the following
    /// sections in the
    /// *Amazon SageMaker AI Developer Guide*:
    ///
    /// * For information about how to add streaming support to a model, see [How
    ///   Containers Serve
    ///   Requests](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-inference-code.html#your-algorithms-inference-code-how-containe-serves-requests).
    ///
    /// * For information about how to process the streaming response, see [Invoke
    ///   real-time
    ///   endpoints](https://docs.aws.amazon.com/sagemaker/latest/dg/realtime-endpoints-test-endpoints.html).
    ///
    /// Before you can use this operation, your IAM permissions must allow the
    /// `sagemaker:InvokeEndpoint` action. For more information about Amazon
    /// SageMaker AI actions for IAM policies, see [Actions, resources, and
    /// condition keys for Amazon SageMaker
    /// AI](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonsagemaker.html) in the *IAM Service Authorization
    /// Reference*.
    ///
    /// Amazon SageMaker AI strips all POST headers except those supported by the
    /// API. Amazon SageMaker AI might add
    /// additional headers. You should not rely on the behavior of headers outside
    /// those
    /// enumerated in the request syntax.
    ///
    /// Calls to `InvokeEndpointWithResponseStream` are authenticated by using
    /// Amazon Web Services Signature Version 4. For information, see
    /// [Authenticating Requests (Amazon Web Services Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) in the
    /// *Amazon S3 API Reference*.
    pub fn invokeEndpointWithResponseStream(self: *Self, allocator: std.mem.Allocator, input: invoke_endpoint_with_response_stream.InvokeEndpointWithResponseStreamInput, options: invoke_endpoint_with_response_stream.Options) !invoke_endpoint_with_response_stream.InvokeEndpointWithResponseStreamOutput {
        return invoke_endpoint_with_response_stream.execute(self, allocator, input, options);
    }
};
