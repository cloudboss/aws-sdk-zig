const Visibility = @import("visibility.zig").Visibility;

/// The configuration of the placeholder options in a text control.
pub const TextControlPlaceholderOptions = struct {
    /// The visibility configuration of the placeholder options in a text control.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
