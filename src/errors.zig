//! AWS Error Types
//!
//! Common error types used across the SDK.

const std = @import("std");

/// Base diagnostic information for AWS service errors
pub const Diagnostic = struct {
    /// Error code from AWS (e.g., "ExpiredTokenException")
    code: []const u8,
    /// Human-readable error message
    message: []const u8,
    /// AWS request ID for debugging
    request_id: []const u8,
    /// HTTP status code
    http_status: u16,

    /// Check if this error is retryable
    pub fn isRetryable(self: *const Diagnostic) bool {
        // Throttling errors
        if (std.mem.eql(u8, self.code, "Throttling") or
            std.mem.eql(u8, self.code, "ThrottlingException") or
            std.mem.eql(u8, self.code, "RequestThrottled") or
            std.mem.eql(u8, self.code, "RequestThrottledException") or
            std.mem.eql(u8, self.code, "ProvisionedThroughputExceededException") or
            std.mem.eql(u8, self.code, "TooManyRequestsException"))
        {
            return true;
        }

        // Service unavailable / transient errors
        if (self.http_status == 500 or
            self.http_status == 502 or
            self.http_status == 503 or
            self.http_status == 504)
        {
            return true;
        }

        return false;
    }
};

/// Calculate exponential backoff delay for retry
pub fn calculateBackoff(attempt: u32, base_delay_ms: u32, max_delay_ms: u32) u64 {
    const max_shift: u5 = @min(attempt, 20);
    const delay = @as(u64, base_delay_ms) << max_shift;
    return @min(delay, max_delay_ms);
}

/// Check if an HTTP error is retryable
pub fn isRetryableHttpError(err: anyerror) bool {
    return switch (err) {
        error.ConnectionRefused,
        error.ConnectionResetByPeer,
        error.ConnectionTimedOut,
        error.NetworkUnreachable,
        error.HostUnreachable,
        error.TemporaryNameServerFailure,
        => true,
        else => false,
    };
}

test "Diagnostic isRetryable" {
    const throttling = Diagnostic{
        .code = "ThrottlingException",
        .message = "Rate exceeded",
        .request_id = "123",
        .http_status = 400,
    };
    try std.testing.expect(throttling.isRetryable());

    const server_error = Diagnostic{
        .code = "InternalServerError",
        .message = "Internal error",
        .request_id = "456",
        .http_status = 500,
    };
    try std.testing.expect(server_error.isRetryable());

    const client_error = Diagnostic{
        .code = "ValidationException",
        .message = "Invalid input",
        .request_id = "789",
        .http_status = 400,
    };
    try std.testing.expect(!client_error.isRetryable());
}

test "calculateBackoff" {
    // First attempt: 100ms
    try std.testing.expectEqual(@as(u64, 100), calculateBackoff(0, 100, 20_000));
    // Second attempt: 200ms
    try std.testing.expectEqual(@as(u64, 200), calculateBackoff(1, 100, 20_000));
    // Third attempt: 400ms
    try std.testing.expectEqual(@as(u64, 400), calculateBackoff(2, 100, 20_000));
    // Capped at max
    try std.testing.expectEqual(@as(u64, 20_000), calculateBackoff(10, 100, 20_000));
}
