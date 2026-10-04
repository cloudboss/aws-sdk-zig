/// The vendor-specified custom profile options
pub const AbWatermarkingCustomProfile = struct {
    /// The frequency with which watermarks will be embedded, in milliseconds.
    embedding_frequency: f64,

    /// The number of frames after scene-cut to embed the watermark.
    scene_cut: f64,

    /// The target PSNR of the watermarked frame
    target_psnr: f64,

    pub const json_field_names = .{
        .embedding_frequency = "EmbeddingFrequency",
        .scene_cut = "SceneCut",
        .target_psnr = "TargetPsnr",
    };
};
