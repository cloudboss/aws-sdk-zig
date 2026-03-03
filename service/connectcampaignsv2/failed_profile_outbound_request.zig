const ProfileOutboundRequestFailureCode = @import("profile_outbound_request_failure_code.zig").ProfileOutboundRequestFailureCode;

/// Failure details for a profile outbound request
pub const FailedProfileOutboundRequest = struct {
    client_token: ?[]const u8 = null,

    failure_code: ?ProfileOutboundRequestFailureCode = null,

    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .failure_code = "failureCode",
        .id = "id",
    };
};
