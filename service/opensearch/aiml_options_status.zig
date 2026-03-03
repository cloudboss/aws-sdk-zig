const AIMLOptionsOutput = @import("aiml_options_output.zig").AIMLOptionsOutput;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of machine learning options on the specified domain.
pub const AIMLOptionsStatus = struct {
    /// Machine learning options on the specified domain.
    options: ?AIMLOptionsOutput = null,

    status: ?OptionStatus = null,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
