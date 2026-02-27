const Identity = @import("identity.zig").Identity;

/// Summary of the details of a `ChannelBan`.
pub const ChannelBanSummary = struct {
    /// The member being banned from a channel.
    member: ?Identity,

    pub const json_field_names = .{
        .member = "Member",
    };
};
