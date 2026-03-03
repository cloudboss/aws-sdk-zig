const SourceAuthType = @import("source_auth_type.zig").SourceAuthType;

/// Information about the authorization settings for CodeBuild to access the
/// source code to be
/// built.
pub const SourceAuth = struct {
    /// The resource value that applies to the specified authorization type.
    resource: ?[]const u8 = null,

    /// The authorization type to use. Valid options are OAUTH, CODECONNECTIONS, or
    /// SECRETS_MANAGER.
    @"type": SourceAuthType,

    pub const json_field_names = .{
        .resource = "resource",
        .@"type" = "type",
    };
};
