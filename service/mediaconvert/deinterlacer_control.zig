/// - When set to NORMAL (default), the deinterlacer does not convert frames
/// that are tagged in metadata as progressive. It will only convert those that
/// are tagged as some other type. - When set to FORCE_ALL_FRAMES, the
/// deinterlacer converts every frame to progressive - even those that are
/// already tagged as progressive. Turn Force mode on only if there is a good
/// chance that the metadata has tagged frames as progressive when they are not
/// progressive. Do not turn on otherwise; processing frames that are already
/// progressive into progressive will probably result in lower quality video.
pub const DeinterlacerControl = enum {
    force_all_frames,
    normal,

    pub const json_field_names = .{
        .force_all_frames = "FORCE_ALL_FRAMES",
        .normal = "NORMAL",
    };
};
