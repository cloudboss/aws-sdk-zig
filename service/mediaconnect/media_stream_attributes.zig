const Fmtp = @import("fmtp.zig").Fmtp;

/// Attributes that are related to the media stream.
pub const MediaStreamAttributes = struct {
    /// The settings that you want to use to define the media stream.
    fmtp: Fmtp,

    /// The audio language, in a format that is recognized by the receiver.
    lang: ?[]const u8 = null,

    pub const json_field_names = .{
        .fmtp = "Fmtp",
        .lang = "Lang",
    };
};
