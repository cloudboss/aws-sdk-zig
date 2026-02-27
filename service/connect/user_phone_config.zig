const PhoneType = @import("phone_type.zig").PhoneType;

/// Contains information about the phone configuration settings for a user.
pub const UserPhoneConfig = struct {
    /// The After Call Work (ACW) timeout setting, in seconds. This parameter has a
    /// minimum value of 0 and a maximum
    /// value of 2,000,000 seconds (24 days). Enter 0 if you don't want to allocate
    /// a specific amount of ACW time. It
    /// essentially means an indefinite amount of time. When the conversation ends,
    /// ACW starts; the agent must choose Close
    /// contact to end ACW.
    ///
    /// When returned by a `SearchUsers` call, `AfterContactWorkTimeLimit` is
    /// returned in
    /// milliseconds.
    after_contact_work_time_limit: i32 = 0,

    /// The Auto accept setting.
    auto_accept: bool = false,

    /// The phone number for the user's desk phone.
    desk_phone_number: ?[]const u8,

    /// The persistent connection setting for the user.
    persistent_connection: ?bool,

    /// The phone type.
    phone_type: PhoneType,

    pub const json_field_names = .{
        .after_contact_work_time_limit = "AfterContactWorkTimeLimit",
        .auto_accept = "AutoAccept",
        .desk_phone_number = "DeskPhoneNumber",
        .persistent_connection = "PersistentConnection",
        .phone_type = "PhoneType",
    };
};
