//! AWS SDK for Zig - Runtime Library
//!
//! Minimal runtime supporting generated service clients.

const std = @import("std");

pub const checksum = @import("checksum.zig");
pub const credentials = @import("credentials.zig");
pub const signing = @import("signing.zig");
pub const http = @import("http.zig");
pub const config = @import("config.zig");
pub const errors = @import("errors.zig");
pub const date = @import("date.zig");
pub const endpoint = @import("endpoint.zig");
pub const s3_endpoint = @import("s3_endpoint.zig");
pub const imds = @import("imds.zig");
pub const ecs = @import("ecs.zig");
pub const json = @import("json.zig");
pub const xml = @import("xml.zig");
pub const url = @import("url.zig");
pub const map = @import("map.zig");
pub const waiter = @import("waiter.zig");
pub const sts_common = @import("sts_common.zig");
pub const web_identity = @import("web_identity.zig");
pub const process_creds = @import("process.zig");
pub const sso = @import("sso.zig");
pub const assume_role = @import("assume_role.zig");

// Re-exports
pub const Credentials = credentials.Credentials;
pub const CredentialsProvider = credentials.CredentialsProvider;
pub const Config = config.Config;
pub const Diagnostic = errors.Diagnostic;
pub const ImdsClient = imds.Client;
pub const EcsProvider = ecs.Provider;

test {
    std.testing.refAllDecls(@This());
}
