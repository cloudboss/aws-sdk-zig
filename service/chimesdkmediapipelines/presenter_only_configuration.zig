const PresenterPosition = @import("presenter_position.zig").PresenterPosition;

/// Defines the configuration for a presenter-only video tile.
pub const PresenterOnlyConfiguration = struct {
    /// Defines the position of the presenter video tile. Default: `TopRight`.
    presenter_position: ?PresenterPosition,

    pub const json_field_names = .{
        .presenter_position = "PresenterPosition",
    };
};
