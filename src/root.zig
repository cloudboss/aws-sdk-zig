//! AWS SDK for Zig - Runtime Library
//!
//! Minimal runtime supporting generated service clients.

const std = @import("std");

pub const credentials = @import("credentials.zig");
pub const signing = @import("signing.zig");
pub const http = @import("http.zig");
pub const config = @import("config.zig");
pub const errors = @import("errors.zig");

// Re-exports
pub const Credentials = credentials.Credentials;
pub const CredentialsProvider = credentials.CredentialsProvider;
pub const Config = config.Config;
pub const Diagnostic = errors.Diagnostic;

test {
    std.testing.refAllDecls(@This());
}
