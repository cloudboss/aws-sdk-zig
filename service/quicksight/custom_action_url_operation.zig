const URLTargetConfiguration = @import("url_target_configuration.zig").URLTargetConfiguration;

/// The URL operation that opens a link to another webpage.
pub const CustomActionURLOperation = struct {
    /// The target of the `CustomActionURLOperation`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `NEW_TAB`: Opens the target URL in a new browser tab.
    ///
    /// * `NEW_WINDOW`: Opens the target URL in a new browser window.
    ///
    /// * `SAME_TAB`: Opens the target URL in the same browser tab.
    url_target: URLTargetConfiguration,

    /// THe URL link of the `CustomActionURLOperation`.
    url_template: []const u8,

    pub const json_field_names = .{
        .url_target = "URLTarget",
        .url_template = "URLTemplate",
    };
};
