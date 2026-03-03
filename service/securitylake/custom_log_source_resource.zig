const CustomLogSourceAttributes = @import("custom_log_source_attributes.zig").CustomLogSourceAttributes;
const CustomLogSourceProvider = @import("custom_log_source_provider.zig").CustomLogSourceProvider;

/// Amazon Security Lake can collect logs and events from third-party custom
/// sources.
pub const CustomLogSourceResource = struct {
    /// The attributes of a third-party custom source.
    attributes: ?CustomLogSourceAttributes = null,

    /// The details of the log provider for a third-party custom source.
    provider: ?CustomLogSourceProvider = null,

    /// The name for a third-party custom source. This must be a Regionally unique
    /// value.
    source_name: ?[]const u8 = null,

    /// The version for a third-party custom source. This must be a Regionally
    /// unique value.
    source_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .provider = "provider",
        .source_name = "sourceName",
        .source_version = "sourceVersion",
    };
};
