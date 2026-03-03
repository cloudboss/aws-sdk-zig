const All = @import("all.zig").All;

/// The filter to use to identify the subset of headers to inspect in a web
/// request.
///
/// You must specify exactly one setting: either `All`, `IncludedHeaders`, or
/// `ExcludedHeaders`.
///
/// Example JSON: `"MatchPattern": { "ExcludedHeaders": [ "KeyToExclude1",
/// "KeyToExclude2" ] }`
pub const HeaderMatchPattern = struct {
    /// Inspect all headers.
    all: ?All = null,

    /// Inspect only the headers whose keys don't match any of the strings specified
    /// here.
    excluded_headers: ?[]const []const u8 = null,

    /// Inspect only the headers that have a key that matches one of the strings
    /// specified here.
    included_headers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .all = "All",
        .excluded_headers = "ExcludedHeaders",
        .included_headers = "IncludedHeaders",
    };
};
