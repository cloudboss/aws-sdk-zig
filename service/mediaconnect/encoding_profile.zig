pub const EncodingProfile = enum {
    distribution_h264_default,
    contribution_h264_default,

    pub const json_field_names = .{
        .distribution_h264_default = "DISTRIBUTION_H264_DEFAULT",
        .contribution_h264_default = "CONTRIBUTION_H264_DEFAULT",
    };
};
