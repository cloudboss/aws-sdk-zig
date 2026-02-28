const Type = @import("type.zig").Type;

/// The HTTP package configuration properties for the requested VOD source.
pub const HttpPackageConfiguration = struct {
    /// The relative path to the URL for this VOD source. This is combined with
    /// `SourceLocation::HttpConfiguration::BaseUrl` to form a valid URL.
    path: []const u8,

    /// The name of the source group. This has to match one of the
    /// `Channel::Outputs::SourceGroup`.
    source_group: []const u8,

    /// The streaming protocol for this package configuration. Supported values are
    /// `HLS` and `DASH`.
    @"type": Type,

    pub const json_field_names = .{
        .path = "Path",
        .source_group = "SourceGroup",
        .@"type" = "Type",
    };
};
