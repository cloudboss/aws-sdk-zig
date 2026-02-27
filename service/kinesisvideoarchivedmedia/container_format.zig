pub const ContainerFormat = enum {
    fragmented_mp4,
    mpeg_ts,

    pub const json_field_names = .{
        .fragmented_mp4 = "FRAGMENTED_MP4",
        .mpeg_ts = "MPEG_TS",
    };
};
