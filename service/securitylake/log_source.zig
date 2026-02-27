const LogSourceResource = @import("log_source_resource.zig").LogSourceResource;

/// Amazon Security Lake can collect logs and events from natively-supported
/// Amazon Web Services services and custom sources.
pub const LogSource = struct {
    /// Specify the account from which you want to collect logs.
    account: ?[]const u8,

    /// Specify the Regions from which you want to collect logs.
    region: ?[]const u8,

    /// Specify the sources from which you want to collect logs.
    sources: ?[]const LogSourceResource,

    pub const json_field_names = .{
        .account = "account",
        .region = "region",
        .sources = "sources",
    };
};
