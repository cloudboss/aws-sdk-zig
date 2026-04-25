const Channel = @import("channel.zig").Channel;
const PhoneType = @import("phone_type.zig").PhoneType;

/// Configuration settings for phone type and phone number.
pub const PhoneNumberConfig = struct {
    /// The channel for this phone number configuration. **Only `VOICE` is supported
    /// for this data type.**
    channel: Channel,

    /// The phone number for the user's desk phone.
    phone_number: ?[]const u8 = null,

    /// The phone type. Valid values: SOFT_PHONE, DESK_PHONE.
    phone_type: PhoneType,

    pub const json_field_names = .{
        .channel = "Channel",
        .phone_number = "PhoneNumber",
        .phone_type = "PhoneType",
    };
};
