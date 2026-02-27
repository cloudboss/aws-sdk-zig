const RequestPayloadPart = @import("request_payload_part.zig").RequestPayloadPart;

/// Request stream event union.
pub const RequestStreamEvent = union(enum) {
    /// Payload part event.
    payload_part: ?RequestPayloadPart,

    pub const json_field_names = .{
        .payload_part = "PayloadPart",
    };
};
