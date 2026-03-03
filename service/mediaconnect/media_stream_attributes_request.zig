const FmtpRequest = @import("fmtp_request.zig").FmtpRequest;

/// Attributes that are related to the media stream.
pub const MediaStreamAttributesRequest = struct {
    /// The settings that you want to use to define the media stream.
    fmtp: ?FmtpRequest = null,

    /// The audio language, in a format that is recognized by the receiver.
    lang: ?[]const u8 = null,

    pub const json_field_names = .{
        .fmtp = "Fmtp",
        .lang = "Lang",
    };
};
