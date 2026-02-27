/// Use Profile to set the MPEG-2 profile for the video output.
pub const Mpeg2CodecProfile = enum {
    main,
    profile_422,

    pub const json_field_names = .{
        .main = "MAIN",
        .profile_422 = "PROFILE_422",
    };
};
