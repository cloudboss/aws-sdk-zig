const AnchorOption = @import("anchor_option.zig").AnchorOption;

/// The date configuration of the filter.
pub const AnchorDateConfiguration = struct {
    /// The options for the date configuration. Choose one of the options below:
    ///
    /// * `NOW`
    anchor_option: ?AnchorOption = null,

    /// The name of the parameter that is used for the anchor date configuration.
    parameter_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .anchor_option = "AnchorOption",
        .parameter_name = "ParameterName",
    };
};
