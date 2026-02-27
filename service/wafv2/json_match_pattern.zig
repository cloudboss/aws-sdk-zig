const All = @import("all.zig").All;

/// The patterns to look for in the JSON body. WAF inspects the results of these
/// pattern matches against the rule inspection criteria. This is used with the
/// FieldToMatch option `JsonBody`.
pub const JsonMatchPattern = struct {
    /// Match all of the elements. See also
    /// `MatchScope`
    /// in JsonBody.
    ///
    /// You must specify either this setting or the `IncludedPaths` setting, but not
    /// both.
    all: ?All,

    /// Match only the specified include paths. See also
    /// `MatchScope`
    /// in JsonBody.
    ///
    /// Provide the include paths using JSON Pointer syntax. For example,
    /// `"IncludedPaths":
    /// ["/dogs/0/name", "/dogs/1/name"]`. For information about this syntax, see
    /// the
    /// Internet Engineering Task Force (IETF) documentation [JavaScript Object
    /// Notation (JSON)
    /// Pointer](https://tools.ietf.org/html/rfc6901).
    ///
    /// You must specify either this setting or the `All` setting, but not
    /// both.
    ///
    /// Don't use this option to include all paths. Instead, use the `All`
    /// setting.
    included_paths: ?[]const []const u8,

    pub const json_field_names = .{
        .all = "All",
        .included_paths = "IncludedPaths",
    };
};
