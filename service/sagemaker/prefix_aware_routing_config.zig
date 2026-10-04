/// The configuration for prefix-aware routing on a SageMaker real-time
/// inference endpoint. Specify `PrefixLength` and `ConcurrencyThreshold` to
/// control routing behavior.
pub const PrefixAwareRoutingConfig = struct {
    /// The maximum number of in-flight requests on the target instance before the
    /// endpoint routes to another instance. Required when `RoutingStrategy` is
    /// `PREFIX_AWARE`. When in-flight requests on the prefix-selected instance
    /// reach this threshold, the endpoint routes the request to an instance with
    /// more available capacity.
    concurrency_threshold: ?i32 = null,

    /// The maximum length of the prefix used for routing decisions. Required when
    /// `RoutingStrategy` is `PREFIX_AWARE`.
    ///
    /// * For the SageMaker Runtime `InvokeEndpoint` and
    ///   `InvokeEndpointWithResponseStream` APIs, this value specifies the number
    ///   of bytes from the beginning of the request body.
    /// * For OpenAI-compatible API, this value specifies the number of characters
    ///   from the text content of the messages array.
    ///
    /// The endpoint routes requests that share the same prefix to the same
    /// instance. Set this value to cover shared content (such as system prompts)
    /// plus enough unique content to distribute workloads across instances.
    prefix_length: ?i32 = null,

    pub const json_field_names = .{
        .concurrency_threshold = "ConcurrencyThreshold",
        .prefix_length = "PrefixLength",
    };
};
