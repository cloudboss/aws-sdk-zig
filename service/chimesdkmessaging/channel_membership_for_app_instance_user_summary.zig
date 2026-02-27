const AppInstanceUserMembershipSummary = @import("app_instance_user_membership_summary.zig").AppInstanceUserMembershipSummary;
const ChannelSummary = @import("channel_summary.zig").ChannelSummary;

/// Summary of the channel membership details of an `AppInstanceUser`.
pub const ChannelMembershipForAppInstanceUserSummary = struct {
    /// Returns the channel membership data for an `AppInstance`.
    app_instance_user_membership_summary: ?AppInstanceUserMembershipSummary,

    /// Returns the channel data for an `AppInstance`.
    channel_summary: ?ChannelSummary,

    pub const json_field_names = .{
        .app_instance_user_membership_summary = "AppInstanceUserMembershipSummary",
        .channel_summary = "ChannelSummary",
    };
};
