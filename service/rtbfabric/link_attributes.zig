const ResponderErrorMaskingForHttpCode = @import("responder_error_masking_for_http_code.zig").ResponderErrorMaskingForHttpCode;

/// Describes the attributes of a link.
pub const LinkAttributes = struct {
    /// The customer-provided unique identifier of the link.
    customer_provided_id: ?[]const u8,

    /// Describes the masking for HTTP error codes.
    responder_error_masking: ?[]const ResponderErrorMaskingForHttpCode,

    pub const json_field_names = .{
        .customer_provided_id = "customerProvidedId",
        .responder_error_masking = "responderErrorMasking",
    };
};
