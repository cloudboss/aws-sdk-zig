const Identity = @import("identity.zig").Identity;

/// Summary of the details of a `ChannelModerator`.
pub const ChannelModeratorSummary = struct {
    /// The data for a moderator.
    moderator: ?Identity,

    pub const json_field_names = .{
        .moderator = "Moderator",
    };
};
