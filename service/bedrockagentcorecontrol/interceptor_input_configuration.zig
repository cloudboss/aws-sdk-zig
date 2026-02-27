/// The input configuration of the interceptor.
pub const InterceptorInputConfiguration = struct {
    /// Indicates whether to pass request headers as input into the interceptor.
    /// When set to true, request headers will be passed.
    pass_request_headers: bool,

    pub const json_field_names = .{
        .pass_request_headers = "passRequestHeaders",
    };
};
