//! AWS Error Types
//!
//! Common error types used across the SDK.

const std = @import("std");

/// Base diagnostic information for AWS service errors
pub const Diagnostic = struct {
    /// Error code from AWS (e.g., "ExpiredTokenException")
    code: []const u8 = "",
    /// Human-readable error message
    message: []const u8 = "",
    /// AWS request ID for debugging
    request_id: []const u8 = "",
    /// HTTP status code
    http_status: u16 = 0,

    /// Check if this error is retryable
    pub fn isRetryable(self: *const Diagnostic) bool {
        if (isThrottlingError(self.code) or isTransientErrorCode(self.code)) return true;

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

    pub fn isTransientError(self: *const Diagnostic) bool {
        return isTransientErrorCode(self.code);
    }
};

pub const throttling_error_codes = [_][]const u8{
    "Throttling",
    "ThrottlingException",
    "ThrottledException",
    "RequestThrottledException",
    "TooManyRequestsException",
    "ProvisionedThroughputExceededException",
    "TransactionInProgressException",
    "RequestLimitExceeded",
    "BandwidthLimitExceeded",
    "LimitExceededException",
    "RequestThrottled",
    "SlowDown",
    "PriorRequestNotComplete",
    "EC2ThrottledException",
};

pub const transient_error_codes = [_][]const u8{
    "RequestTimeout",
    "RequestTimeoutException",
};

pub fn isThrottlingError(code: []const u8) bool {
    return matchesErrorCode(code, throttling_error_codes[0..]);
}

pub fn isTransientErrorCode(code: []const u8) bool {
    return matchesErrorCode(code, transient_error_codes[0..]);
}

pub fn bodyContainsErrorCode(
    body: []const u8,
    codes: []const []const u8,
) bool {
    for (codes) |code| {
        if (std.mem.indexOf(u8, body, code) != null) return true;
    }
    return false;
}

fn matchesErrorCode(code: []const u8, codes: []const []const u8) bool {
    for (codes) |known| {
        if (std.mem.eql(u8, code, known)) return true;
    }
    return false;
}

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

    const timeout = Diagnostic{
        .code = "RequestTimeout",
        .message = "timed out",
        .request_id = "321",
        .http_status = 400,
    };
    try std.testing.expect(timeout.isRetryable());
    try std.testing.expect(timeout.isTransientError());

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
    try std.testing.expect(!client_error.isTransientError());
}

test "isThrottlingError recognizes all throttle codes" {
    for (throttling_error_codes) |code| {
        try std.testing.expect(isThrottlingError(code));
    }
    try std.testing.expect(!isThrottlingError("RequestTimeout"));
}

test "isTransientError recognizes timeout codes" {
    for (transient_error_codes) |code| {
        try std.testing.expect(isTransientErrorCode(code));
    }
    try std.testing.expect(!isTransientErrorCode("Throttling"));
}

test "bodyContainsErrorCode finds codes in body" {
    const body = "Error: RequestTimeoutException occurred";
    try std.testing.expect(bodyContainsErrorCode(body, transient_error_codes[0..]));
    try std.testing.expect(!bodyContainsErrorCode(body, throttling_error_codes[0..]));
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
