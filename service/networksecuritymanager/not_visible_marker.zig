/// Indicates that details are not visible because of cross-account
/// restrictions.
pub const NotVisibleMarker = struct {
    /// The reason the details are not visible.
    reason: []const u8,

    pub const json_field_names = .{
        .reason = "reason",
    };
};
