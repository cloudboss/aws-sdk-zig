const aws = @import("aws");

/// Which audit checks are enabled and disabled for this account.
pub const AuditCheckConfiguration = struct {
    /// A structure containing the configName and corresponding configValue for
    /// configuring audit checks.
    configuration: ?[]const aws.map.StringMapEntry,

    /// True if this audit check is enabled for this account.
    enabled: bool = false,

    pub const json_field_names = .{
        .configuration = "configuration",
        .enabled = "enabled",
    };
};
