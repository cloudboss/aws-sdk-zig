/// Container for the owner's display name and ID.
pub const Owner = struct {
    display_name: ?[]const u8,

    /// Container for the ID of the owner.
    id: ?[]const u8,
};
