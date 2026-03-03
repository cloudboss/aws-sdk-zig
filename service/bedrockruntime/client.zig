const aws = @import("aws");
const std = @import("std");

const apply_guardrail = @import("apply_guardrail.zig");
const converse_ = @import("converse.zig");
const converse_stream = @import("converse_stream.zig");
const count_tokens = @import("count_tokens.zig");
const get_async_invoke = @import("get_async_invoke.zig");
const invoke_model = @import("invoke_model.zig");
const invoke_model_with_bidirectional_stream = @import("invoke_model_with_bidirectional_stream.zig");
const invoke_model_with_response_stream = @import("invoke_model_with_response_stream.zig");
const list_async_invokes = @import("list_async_invokes.zig");
const start_async_invoke = @import("start_async_invoke.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock Runtime";

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

    /// The action to apply a guardrail.
    ///
    /// For troubleshooting some of the common errors you might encounter when using
    /// the `ApplyGuardrail` API, see [Troubleshooting Amazon Bedrock API Error
    /// Codes](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html) in the Amazon Bedrock User Guide
    pub fn applyGuardrail(self: *Self, allocator: std.mem.Allocator, input: apply_guardrail.ApplyGuardrailInput, options: CallOptions) !apply_guardrail.ApplyGuardrailOutput {
        return apply_guardrail.execute(self, allocator, input, options);
    }

    /// Sends messages to the specified Amazon Bedrock model. `Converse` provides a
    /// consistent interface that works with all models that support messages. This
    /// allows you to write code once and use it with different models. If a model
    /// has unique inference parameters, you can also pass those unique parameters
    /// to the model.
    ///
    /// Amazon Bedrock doesn't store any text, images, or documents that you provide
    /// as content. The data is only used to generate the response.
    ///
    /// You can submit a prompt by including it in the `messages` field, specifying
    /// the `modelId` of a foundation model or inference profile to run inference on
    /// it, and including any other fields that are relevant to your use case.
    ///
    /// You can also submit a prompt from Prompt management by specifying the ARN of
    /// the prompt version and including a map of variables to values in the
    /// `promptVariables` field. You can append more messages to the prompt by using
    /// the `messages` field. If you use a prompt from Prompt management, you can't
    /// include the following fields in the request: `additionalModelRequestFields`,
    /// `inferenceConfig`, `system`, or `toolConfig`. Instead, these fields must be
    /// defined through Prompt management. For more information, see [Use a prompt
    /// from Prompt
    /// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-use.html).
    ///
    /// For information about the Converse API, see *Use the Converse API* in the
    /// *Amazon Bedrock User Guide*. To use a guardrail, see *Use a guardrail with
    /// the Converse API* in the *Amazon Bedrock User Guide*. To use a tool with a
    /// model, see *Tool use (Function calling)* in the *Amazon Bedrock User Guide*
    ///
    /// For example code, see *Converse API examples* in the *Amazon Bedrock User
    /// Guide*.
    ///
    /// This operation requires permission for the `bedrock:InvokeModel` action.
    ///
    /// To deny all inference access to resources that you specify in the modelId
    /// field, you need to deny access to the `bedrock:InvokeModel` and
    /// `bedrock:InvokeModelWithResponseStream` actions. Doing this also denies
    /// access to the resource through the base inference actions
    /// ([InvokeModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_InvokeModel.html) and [InvokeModelWithResponseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_InvokeModelWithResponseStream.html)). For more information see [Deny access for inference on specific models](https://docs.aws.amazon.com/bedrock/latest/userguide/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-deny-inference).
    ///
    /// For troubleshooting some of the common errors you might encounter when using
    /// the `Converse` API, see [Troubleshooting Amazon Bedrock API Error
    /// Codes](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html) in the Amazon Bedrock User Guide
    pub fn converse(self: *Self, allocator: std.mem.Allocator, input: converse_.ConverseInput, options: CallOptions) !converse_.ConverseOutput {
        return converse_.execute(self, allocator, input, options);
    }

    /// Sends messages to the specified Amazon Bedrock model and returns the
    /// response in a stream. `ConverseStream` provides a consistent API that works
    /// with all Amazon Bedrock models that support messages. This allows you to
    /// write code once and use it with different models. Should a model have unique
    /// inference parameters, you can also pass those unique parameters to the
    /// model.
    ///
    /// To find out if a model supports streaming, call
    /// [GetFoundationModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetFoundationModel.html) and check the `responseStreamingSupported` field in the response.
    ///
    /// The CLI doesn't support streaming operations in Amazon Bedrock, including
    /// `ConverseStream`.
    ///
    /// Amazon Bedrock doesn't store any text, images, or documents that you provide
    /// as content. The data is only used to generate the response.
    ///
    /// You can submit a prompt by including it in the `messages` field, specifying
    /// the `modelId` of a foundation model or inference profile to run inference on
    /// it, and including any other fields that are relevant to your use case.
    ///
    /// You can also submit a prompt from Prompt management by specifying the ARN of
    /// the prompt version and including a map of variables to values in the
    /// `promptVariables` field. You can append more messages to the prompt by using
    /// the `messages` field. If you use a prompt from Prompt management, you can't
    /// include the following fields in the request: `additionalModelRequestFields`,
    /// `inferenceConfig`, `system`, or `toolConfig`. Instead, these fields must be
    /// defined through Prompt management. For more information, see [Use a prompt
    /// from Prompt
    /// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-use.html).
    ///
    /// For information about the Converse API, see *Use the Converse API* in the
    /// *Amazon Bedrock User Guide*. To use a guardrail, see *Use a guardrail with
    /// the Converse API* in the *Amazon Bedrock User Guide*. To use a tool with a
    /// model, see *Tool use (Function calling)* in the *Amazon Bedrock User Guide*
    ///
    /// For example code, see *Conversation streaming example* in the *Amazon
    /// Bedrock User Guide*.
    ///
    /// This operation requires permission for the
    /// `bedrock:InvokeModelWithResponseStream` action.
    ///
    /// To deny all inference access to resources that you specify in the modelId
    /// field, you need to deny access to the `bedrock:InvokeModel` and
    /// `bedrock:InvokeModelWithResponseStream` actions. Doing this also denies
    /// access to the resource through the base inference actions
    /// ([InvokeModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_InvokeModel.html) and [InvokeModelWithResponseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_InvokeModelWithResponseStream.html)). For more information see [Deny access for inference on specific models](https://docs.aws.amazon.com/bedrock/latest/userguide/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-deny-inference).
    ///
    /// For troubleshooting some of the common errors you might encounter when using
    /// the `ConverseStream` API, see [Troubleshooting Amazon Bedrock API Error
    /// Codes](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html) in the Amazon Bedrock User Guide
    pub fn converseStream(self: *Self, allocator: std.mem.Allocator, input: converse_stream.ConverseStreamInput, options: CallOptions) !converse_stream.ConverseStreamOutput {
        return converse_stream.execute(self, allocator, input, options);
    }

    /// Returns the token count for a given inference request. This operation helps
    /// you estimate token usage before sending requests to foundation models by
    /// returning the token count that would be used if the same input were sent to
    /// the model in an inference request.
    ///
    /// Token counting is model-specific because different models use different
    /// tokenization strategies. The token count returned by this operation will
    /// match the token count that would be charged if the same input were sent to
    /// the model in an `InvokeModel` or `Converse` request.
    ///
    /// You can use this operation to:
    ///
    /// * Estimate costs before sending inference requests.
    /// * Optimize prompts to fit within token limits.
    /// * Plan for token usage in your applications.
    ///
    /// This operation accepts the same input formats as `InvokeModel` and
    /// `Converse`, allowing you to count tokens for both raw text inputs and
    /// structured conversation formats.
    ///
    /// The following operations are related to `CountTokens`:
    ///
    /// *
    ///   [InvokeModel](https://docs.aws.amazon.com/bedrock/latest/API/API_runtime_InvokeModel.html) - Sends inference requests to foundation models
    /// *
    ///   [Converse](https://docs.aws.amazon.com/bedrock/latest/API/API_runtime_Converse.html) - Sends conversation-based inference requests to foundation models
    pub fn countTokens(self: *Self, allocator: std.mem.Allocator, input: count_tokens.CountTokensInput, options: CallOptions) !count_tokens.CountTokensOutput {
        return count_tokens.execute(self, allocator, input, options);
    }

    /// Retrieve information about an asynchronous invocation.
    pub fn getAsyncInvoke(self: *Self, allocator: std.mem.Allocator, input: get_async_invoke.GetAsyncInvokeInput, options: CallOptions) !get_async_invoke.GetAsyncInvokeOutput {
        return get_async_invoke.execute(self, allocator, input, options);
    }

    /// Invokes the specified Amazon Bedrock model to run inference using the prompt
    /// and inference parameters provided in the request body. You use model
    /// inference to generate text, images, and embeddings.
    ///
    /// For example code, see *Invoke model code examples* in the *Amazon Bedrock
    /// User Guide*.
    ///
    /// This operation requires permission for the `bedrock:InvokeModel` action.
    ///
    /// To deny all inference access to resources that you specify in the modelId
    /// field, you need to deny access to the `bedrock:InvokeModel` and
    /// `bedrock:InvokeModelWithResponseStream` actions. Doing this also denies
    /// access to the resource through the Converse API actions
    /// ([Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) and [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html)). For more information see [Deny access for inference on specific models](https://docs.aws.amazon.com/bedrock/latest/userguide/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-deny-inference).
    ///
    /// For troubleshooting some of the common errors you might encounter when using
    /// the `InvokeModel` API, see [Troubleshooting Amazon Bedrock API Error
    /// Codes](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html) in the Amazon Bedrock User Guide
    pub fn invokeModel(self: *Self, allocator: std.mem.Allocator, input: invoke_model.InvokeModelInput, options: CallOptions) !invoke_model.InvokeModelOutput {
        return invoke_model.execute(self, allocator, input, options);
    }

    /// Invoke the specified Amazon Bedrock model to run inference using the
    /// bidirectional stream. The response is returned in a stream that remains open
    /// for 8 minutes. A single session can contain multiple prompts and responses
    /// from the model. The prompts to the model are provided as audio files and the
    /// model's responses are spoken back to the user and transcribed.
    ///
    /// It is possible for users to interrupt the model's response with a new
    /// prompt, which will halt the response speech. The model will retain
    /// contextual awareness of the conversation while pivoting to respond to the
    /// new prompt.
    pub fn invokeModelWithBidirectionalStream(self: *Self, allocator: std.mem.Allocator, input: invoke_model_with_bidirectional_stream.InvokeModelWithBidirectionalStreamInput, options: CallOptions) !invoke_model_with_bidirectional_stream.InvokeModelWithBidirectionalStreamOutput {
        return invoke_model_with_bidirectional_stream.execute(self, allocator, input, options);
    }

    /// Invoke the specified Amazon Bedrock model to run inference using the prompt
    /// and inference parameters provided in the request body. The response is
    /// returned in a stream.
    ///
    /// To see if a model supports streaming, call
    /// [GetFoundationModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetFoundationModel.html) and check the `responseStreamingSupported` field in the response.
    ///
    /// The CLI doesn't support streaming operations in Amazon Bedrock, including
    /// `InvokeModelWithResponseStream`.
    ///
    /// For example code, see *Invoke model with streaming code example* in the
    /// *Amazon Bedrock User Guide*.
    ///
    /// This operation requires permissions to perform the
    /// `bedrock:InvokeModelWithResponseStream` action.
    ///
    /// To deny all inference access to resources that you specify in the modelId
    /// field, you need to deny access to the `bedrock:InvokeModel` and
    /// `bedrock:InvokeModelWithResponseStream` actions. Doing this also denies
    /// access to the resource through the Converse API actions
    /// ([Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) and [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html)). For more information see [Deny access for inference on specific models](https://docs.aws.amazon.com/bedrock/latest/userguide/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-deny-inference).
    ///
    /// For troubleshooting some of the common errors you might encounter when using
    /// the `InvokeModelWithResponseStream` API, see [Troubleshooting Amazon Bedrock
    /// API Error
    /// Codes](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html) in the Amazon Bedrock User Guide
    pub fn invokeModelWithResponseStream(self: *Self, allocator: std.mem.Allocator, input: invoke_model_with_response_stream.InvokeModelWithResponseStreamInput, options: CallOptions) !invoke_model_with_response_stream.InvokeModelWithResponseStreamOutput {
        return invoke_model_with_response_stream.execute(self, allocator, input, options);
    }

    /// Lists asynchronous invocations.
    pub fn listAsyncInvokes(self: *Self, allocator: std.mem.Allocator, input: list_async_invokes.ListAsyncInvokesInput, options: CallOptions) !list_async_invokes.ListAsyncInvokesOutput {
        return list_async_invokes.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous invocation.
    ///
    /// This operation requires permission for the `bedrock:InvokeModel` action.
    ///
    /// To deny all inference access to resources that you specify in the modelId
    /// field, you need to deny access to the `bedrock:InvokeModel` and
    /// `bedrock:InvokeModelWithResponseStream` actions. Doing this also denies
    /// access to the resource through the Converse API actions
    /// ([Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) and [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html)). For more information see [Deny access for inference on specific models](https://docs.aws.amazon.com/bedrock/latest/userguide/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-deny-inference).
    pub fn startAsyncInvoke(self: *Self, allocator: std.mem.Allocator, input: start_async_invoke.StartAsyncInvokeInput, options: CallOptions) !start_async_invoke.StartAsyncInvokeOutput {
        return start_async_invoke.execute(self, allocator, input, options);
    }

    pub fn listAsyncInvokesPaginator(self: *Self, params: list_async_invokes.ListAsyncInvokesInput) paginator.ListAsyncInvokesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
