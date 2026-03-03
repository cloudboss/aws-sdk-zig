const JavaScriptSourceMaps = @import("java_script_source_maps.zig").JavaScriptSourceMaps;

/// A structure that contains the configuration for how an app monitor can
/// deobfuscate stack traces.
pub const DeobfuscationConfiguration = struct {
    /// A structure that contains the configuration for how an app monitor can
    /// unminify JavaScript error stack traces using source maps.
    java_script_source_maps: ?JavaScriptSourceMaps = null,

    pub const json_field_names = .{
        .java_script_source_maps = "JavaScriptSourceMaps",
    };
};
