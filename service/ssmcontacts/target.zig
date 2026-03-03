const ChannelTargetInfo = @import("channel_target_info.zig").ChannelTargetInfo;
const ContactTargetInfo = @import("contact_target_info.zig").ContactTargetInfo;

/// The contact or contact channel that's being engaged.
pub const Target = struct {
    /// Information about the contact channel that Incident Manager engages.
    channel_target_info: ?ChannelTargetInfo = null,

    /// Information about the contact that Incident Manager engages.
    contact_target_info: ?ContactTargetInfo = null,

    pub const json_field_names = .{
        .channel_target_info = "ChannelTargetInfo",
        .contact_target_info = "ContactTargetInfo",
    };
};
