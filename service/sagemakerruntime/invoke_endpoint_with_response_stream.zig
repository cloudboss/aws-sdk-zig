const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResponseStream = @import("response_stream.zig").ResponseStream;

pub const InvokeEndpointWithResponseStreamInput = struct {
    /// The desired MIME type of the inference response from the model container.
    accept: ?[]const u8 = null,

    /// Provides input data, in the format specified in the `ContentType`
    /// request header. Amazon SageMaker AI passes all of the data in the body to
    /// the model.
    ///
    /// For information about the format of the request body, see [Common Data
    /// Formats-Inference](https://docs.aws.amazon.com/sagemaker/latest/dg/cdf-inference.html).
    body: []const u8,

    /// The MIME type of the input data in the request body.
    content_type: ?[]const u8 = null,

    /// Provides additional information about a request for an inference submitted
    /// to a model
    /// hosted at an Amazon SageMaker AI endpoint. The information is an opaque
    /// value that is forwarded
    /// verbatim. You could use this value, for example, to provide an ID that you
    /// can use to
    /// track a request or to provide other metadata that a service endpoint was
    /// programmed to
    /// process. The value must consist of no more than 1024 visible US-ASCII
    /// characters as
    /// specified in [Section 3.3.6. Field Value
    /// Components](https://datatracker.ietf.org/doc/html/rfc7230#section-3.2.6) of
    /// the Hypertext Transfer Protocol
    /// (HTTP/1.1).
    ///
    /// The code in your model is responsible for setting or updating any custom
    /// attributes in
    /// the response. If your code does not set this value in the response, an empty
    /// value is
    /// returned. For example, if a custom attribute represents the trace ID, your
    /// model can
    /// prepend the custom attribute with `Trace ID:` in your post-processing
    /// function.
    ///
    /// This feature is currently supported in the Amazon Web Services SDKs but not
    /// in the Amazon SageMaker AI
    /// Python SDK.
    custom_attributes: ?[]const u8 = null,

    /// The name of the endpoint that you specified when you created the endpoint
    /// using the
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/API_CreateEndpoint.html) API.
    endpoint_name: []const u8,

    /// If the endpoint hosts one or more inference components, this parameter
    /// specifies the
    /// name of inference component to invoke for a streaming response.
    inference_component_name: ?[]const u8 = null,

    /// An identifier that you assign to your request.
    inference_id: ?[]const u8 = null,

    /// The ID of a stateful session to handle your request.
    ///
    /// You can't create a stateful session by using the
    /// `InvokeEndpointWithResponseStream` action. Instead, you can create one by
    /// using the `
    /// InvokeEndpoint
    /// ` action. In your request, you
    /// specify `NEW_SESSION` for the `SessionId` request parameter. The
    /// response to that request provides the session ID for the `NewSessionId`
    /// response parameter.
    session_id: ?[]const u8 = null,

    /// If the endpoint hosts multiple containers and is configured to use direct
    /// invocation,
    /// this parameter specifies the host name of the container to invoke.
    target_container_hostname: ?[]const u8 = null,

    /// Specify the production variant to send the inference request to when
    /// invoking an
    /// endpoint that is running two or more variants. Note that this parameter
    /// overrides the
    /// default behavior for the endpoint, which is to distribute the invocation
    /// traffic based
    /// on the variant weights.
    ///
    /// For information about how to use variant targeting to perform a/b testing,
    /// see [Test models in
    /// production](https://docs.aws.amazon.com/sagemaker/latest/dg/model-ab-testing.html)
    target_variant: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept = "Accept",
        .body = "Body",
        .content_type = "ContentType",
        .custom_attributes = "CustomAttributes",
        .endpoint_name = "EndpointName",
        .inference_component_name = "InferenceComponentName",
        .inference_id = "InferenceId",
        .session_id = "SessionId",
        .target_container_hostname = "TargetContainerHostname",
        .target_variant = "TargetVariant",
    };
};

pub const InvokeEndpointWithResponseStreamOutput = struct {
    body: ?ResponseStream = null,

    /// The MIME type of the inference returned from the model container.
    content_type: ?[]const u8 = null,

    /// Provides additional information in the response about the inference returned
    /// by a
    /// model hosted at an Amazon SageMaker AI endpoint. The information is an
    /// opaque value that is
    /// forwarded verbatim. You could use this value, for example, to return an ID
    /// received in
    /// the `CustomAttributes` header of a request or other metadata that a service
    /// endpoint was programmed to produce. The value must consist of no more than
    /// 1024 visible
    /// US-ASCII characters as specified in [Section 3.3.6. Field Value
    /// Components](https://tools.ietf.org/html/rfc7230#section-3.2.6) of the
    /// Hypertext Transfer Protocol (HTTP/1.1). If the customer
    /// wants the custom attribute returned, the model must set the custom attribute
    /// to be
    /// included on the way back.
    ///
    /// The code in your model is responsible for setting or updating any custom
    /// attributes in
    /// the response. If your code does not set this value in the response, an empty
    /// value is
    /// returned. For example, if a custom attribute represents the trace ID, your
    /// model can
    /// prepend the custom attribute with `Trace ID:` in your post-processing
    /// function.
    ///
    /// This feature is currently supported in the Amazon Web Services SDKs but not
    /// in the Amazon SageMaker AI
    /// Python SDK.
    custom_attributes: ?[]const u8 = null,

    /// Identifies the production variant that was invoked.
    invoked_production_variant: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
        .custom_attributes = "CustomAttributes",
        .invoked_production_variant = "InvokedProductionVariant",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeEndpointWithResponseStreamInput, options: Options) !InvokeEndpointWithResponseStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
