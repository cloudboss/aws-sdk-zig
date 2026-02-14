//! Waiter -- polling infrastructure for async AWS operations
//!
//! Provides jittered exponential backoff polling until a desired resource
//! state is reached or a timeout expires. Generated waiter structs use
//! `jitteredDelay` and `AcceptorState` from this module; the polling loop
//! itself lives in each generated waiter so it can call the appropriate
//! service operation directly.

const std = @import("std");

/// Configuration for a waiter's polling behaviour.
pub const WaiterConfig = struct {
    /// Minimum delay between attempts in seconds.
    min_delay_s: u32 = 5,
    /// Maximum delay between attempts in seconds.
    max_delay_s: u32 = 120,
    /// Maximum total wall-clock wait time in seconds.
    max_wait_time_s: u32 = 300,
};

/// The outcome of evaluating a waiter's acceptors against a poll result.
pub const AcceptorState = enum {
    /// The desired state has been reached.
    success,
    /// An unrecoverable condition was detected -- stop polling.
    failure,
    /// The desired state has not yet been reached -- poll again.
    retry,
};

pub const WaiterError = error{
    /// An acceptor matched the failure state.
    WaiterFailed,
    /// `max_wait_time_s` elapsed without reaching the desired state.
    WaiterTimedOut,
};

/// Return a jittered delay between `min_s` and `max_s` (inclusive).
/// Uses a cheap PRNG seeded from the clock -- good enough for backoff jitter.
pub fn jitteredDelay(min_s: u32, max_s: u32) u32 {
    if (min_s >= max_s) return min_s;
    // Seed from nanosecond timestamp for reasonable entropy across calls.
    const seed: u64 = @truncate(@as(u128, @bitCast(std.time.nanoTimestamp())));
    var prng = std.Random.DefaultPrng.init(seed);
    return min_s + prng.random().intRangeAtMost(u32, 0, max_s - min_s);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

test "jitteredDelay returns min when min equals max" {
    const d = jitteredDelay(5, 5);
    try std.testing.expectEqual(@as(u32, 5), d);
}

test "jitteredDelay returns min when min exceeds max" {
    const d = jitteredDelay(10, 3);
    try std.testing.expectEqual(@as(u32, 10), d);
}

test "jitteredDelay result is within bounds" {
    // Run several iterations to gain confidence (not exhaustive).
    for (0..20) |_| {
        const d = jitteredDelay(2, 30);
        try std.testing.expect(d >= 2);
        try std.testing.expect(d <= 30);
    }
}

test "WaiterConfig defaults" {
    const cfg = WaiterConfig{};
    try std.testing.expectEqual(@as(u32, 5), cfg.min_delay_s);
    try std.testing.expectEqual(@as(u32, 120), cfg.max_delay_s);
    try std.testing.expectEqual(@as(u32, 300), cfg.max_wait_time_s);
}
