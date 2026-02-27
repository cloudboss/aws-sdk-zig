const DefaultFilterControlOptions = @import("default_filter_control_options.zig").DefaultFilterControlOptions;

/// The default configuration for all dependent controls of the filter.
pub const DefaultFilterControlConfiguration = struct {
    /// The control option for the `DefaultFilterControlConfiguration`.
    control_options: DefaultFilterControlOptions,

    /// The title of the `DefaultFilterControlConfiguration`. This title is shared
    /// by all controls that are tied to this filter.
    title: []const u8,

    pub const json_field_names = .{
        .control_options = "ControlOptions",
        .title = "Title",
    };
};
