const SecurityConfigType = @import("security_config_type.zig").SecurityConfigType;

/// A summary of a security configuration for OpenSearch Serverless.
pub const SecurityConfigSummary = struct {
    /// The version of the security configuration.
    config_version: ?[]const u8,

    /// The Epoch time when the security configuration was created.
    created_date: ?i64,

    /// The description of the security configuration.
    description: ?[]const u8,

    /// The unique identifier of the security configuration.
    id: ?[]const u8,

    /// The timestamp of when the configuration was last modified.
    last_modified_date: ?i64,

    /// The type of security configuration.
    @"type": ?SecurityConfigType,

    pub const json_field_names = .{
        .config_version = "configVersion",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
        .last_modified_date = "lastModifiedDate",
        .@"type" = "type",
    };
};
