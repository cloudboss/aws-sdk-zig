/// Settings related to the Amazon Chime account. This includes settings that
/// start or stop
/// remote control of shared screens, or start or stop the dial-out option in
/// the Amazon Chime web application. For more information about these settings,
/// see
/// [Use the Policies
/// Page](https://docs.aws.amazon.com/chime/latest/ag/policies.html) in the
/// *Amazon Chime Administration Guide*.
pub const AccountSettings = struct {
    /// Setting that stops or starts remote control of shared screens during
    /// meetings.
    disable_remote_control: ?bool = null,

    /// Setting that allows meeting participants to choose the **Call me at a phone
    /// number** option. For more information, see
    /// [Join a Meeting without the Amazon Chime
    /// App](https://docs.aws.amazon.com/chime/latest/ug/chime-join-meeting.html).
    enable_dial_out: ?bool = null,

    pub const json_field_names = .{
        .disable_remote_control = "DisableRemoteControl",
        .enable_dial_out = "EnableDialOut",
    };
};
