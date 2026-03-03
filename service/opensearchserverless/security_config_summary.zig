const SecurityConfigType = @import("security_config_type.zig").SecurityConfigType;

/// A summary of a security configuration for OpenSearch Serverless.
pub const SecurityConfigSummary = struct {
    /// The version of the security configuration.
    config_version: ?[]const u8 = null,

    /// The Epoch time when the security configuration was created.
    created_date: ?i64 = null,

    /// The description of the security configuration.
    description: ?[]const u8 = null,

    /// The unique identifier of the security configuration.
    id: ?[]const u8 = null,

    /// The timestamp of when the configuration was last modified.
    last_modified_date: ?i64 = null,

    /// The type of security configuration.
    @"type": ?SecurityConfigType = null,

    pub const json_field_names = .{
        .config_version = "configVersion",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
        .last_modified_date = "lastModifiedDate",
        .@"type" = "type",
    };
};
