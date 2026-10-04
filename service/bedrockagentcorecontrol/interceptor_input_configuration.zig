const InterceptorPayloadFilter = @import("interceptor_payload_filter.zig").InterceptorPayloadFilter;

/// The input configuration of the interceptor.
pub const InterceptorInputConfiguration = struct {
    /// Indicates whether to pass request headers as input into the interceptor.
    /// When set to true, request headers will be passed.
    pass_request_headers: bool,

    /// The filter that determines which parts of the request or response payload
    /// are passed as input to the interceptor.
    payload_filter: ?InterceptorPayloadFilter = null,

    pub const json_field_names = .{
        .pass_request_headers = "passRequestHeaders",
        .payload_filter = "payloadFilter",
    };
};
