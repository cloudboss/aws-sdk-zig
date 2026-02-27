const OutputGroupSettings = @import("output_group_settings.zig").OutputGroupSettings;
const Output = @import("output.zig").Output;

/// Output groups for this Live Event. Output groups contain information about
/// where streams should be distributed.
pub const OutputGroup = struct {
    /// Custom output group name optionally defined by the user.
    name: ?[]const u8,

    /// Settings associated with the output group.
    output_group_settings: OutputGroupSettings,

    outputs: []const Output,

    pub const json_field_names = .{
        .name = "Name",
        .output_group_settings = "OutputGroupSettings",
        .outputs = "Outputs",
    };
};
