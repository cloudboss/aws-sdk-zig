const VisualMessageConfiguration = @import("visual_message_configuration.zig").VisualMessageConfiguration;

/// The messages that are displayed on a visual under specific conditions, such
/// as when the visual returns no data.
pub const VisualMessages = struct {
    /// The message that is displayed on a visual when there is no data to display.
    no_data_message: ?VisualMessageConfiguration = null,

    pub const json_field_names = .{
        .no_data_message = "NoDataMessage",
    };
};
