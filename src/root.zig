//! AWS SDK for Zig - Runtime Library
//!
//! Minimal runtime supporting generated service clients.

const std = @import("std");

pub const credentials = @import("credentials.zig");
pub const signing = @import("signing.zig");
pub const http = @import("http.zig");

// Re-exports
pub const Credentials = credentials.Credentials;
pub const CredentialsProvider = credentials.CredentialsProvider;

test {
    std.testing.refAllDecls(@This());
}
