const FunctionUrlAuthType = @import("function_url_auth_type.zig").FunctionUrlAuthType;
const Cors = @import("cors.zig").Cors;
const InvokeMode = @import("invoke_mode.zig").InvokeMode;

/// Details about a Lambda function URL.
pub const FunctionUrlConfig = struct {
    /// The type of authentication that your function URL uses. Set to `AWS_IAM` if
    /// you want to restrict access to authenticated users only. Set to `NONE` if
    /// you want to bypass IAM authentication to create a public endpoint. For more
    /// information, see [Security and auth model for Lambda function
    /// URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html).
    auth_type: FunctionUrlAuthType,

    /// The [cross-origin resource sharing
    /// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) settings for
    /// your function URL.
    cors: ?Cors,

    /// When the function URL was created, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    creation_time: []const u8,

    /// The Amazon Resource Name (ARN) of your function.
    function_arn: []const u8,

    /// The HTTP URL endpoint for your function.
    function_url: []const u8,

    /// Use one of the following options:
    ///
    /// * `BUFFERED` – This is the default option. Lambda invokes your function
    ///   using the `Invoke` API operation. Invocation results are available when
    ///   the payload is complete. The maximum payload size is 6 MB.
    /// * `RESPONSE_STREAM` – Your function streams payload results as they become
    ///   available. Lambda invokes your function using the
    ///   `InvokeWithResponseStream` API operation. The maximum response payload
    ///   size is 200 MB.
    invoke_mode: ?InvokeMode,

    /// When the function URL configuration was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified_time: []const u8,
};
