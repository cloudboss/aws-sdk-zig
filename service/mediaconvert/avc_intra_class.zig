/// Specify the AVC-Intra class of your output. The AVC-Intra class selection
/// determines the output video bit rate depending on the frame rate of the
/// output. Outputs with higher class values have higher bitrates and improved
/// image quality. Note that for Class 4K/2K, MediaConvert supports only 4:2:2
/// chroma subsampling.
pub const AvcIntraClass = enum {
    class_50,
    class_100,
    class_200,
    class_4_k_2_k,

    pub const json_field_names = .{
        .class_50 = "CLASS_50",
        .class_100 = "CLASS_100",
        .class_200 = "CLASS_200",
        .class_4_k_2_k = "CLASS_4K_2K",
    };
};
