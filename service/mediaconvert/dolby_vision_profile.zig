/// Required when you enable Dolby Vision. Use Profile 5 to include
/// frame-interleaved Dolby Vision metadata in your output. Your input must
/// include Dolby Vision metadata or an HDR10 YUV color space. Use Profile 8.1
/// to include frame-interleaved Dolby Vision metadata and HDR10 metadata in
/// your output. Your input must include Dolby Vision metadata.
pub const DolbyVisionProfile = enum {
    profile_5,
    profile_8_1,

    pub const json_field_names = .{
        .profile_5 = "PROFILE_5",
        .profile_8_1 = "PROFILE_8_1",
    };
};
