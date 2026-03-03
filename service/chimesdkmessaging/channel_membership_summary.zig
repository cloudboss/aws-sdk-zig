const Identity = @import("identity.zig").Identity;

/// Summary of the details of a `ChannelMembership`.
pub const ChannelMembershipSummary = struct {
    /// A member's summary data.
    member: ?Identity = null,

    pub const json_field_names = .{
        .member = "Member",
    };
};
