const FailureCode = @import("failure_code.zig").FailureCode;

/// A failed request identified by the unique client token.
pub const FailedRequest = struct {
    client_token: ?[]const u8,

    failure_code: ?FailureCode,

    id: ?[]const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .failure_code = "failureCode",
        .id = "id",
    };
};
