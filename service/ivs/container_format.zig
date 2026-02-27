pub const ContainerFormat = enum {
    ts,
    fragmented_mp4,

    pub const json_field_names = .{
        .ts = "TS",
        .fragmented_mp4 = "FragmentedMP4",
    };
};
