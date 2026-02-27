const Visibility = @import("visibility.zig").Visibility;

/// The configuration of loading animation in free-form layout.
pub const LoadingAnimation = struct {
    /// The visibility configuration of `LoadingAnimation`.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
