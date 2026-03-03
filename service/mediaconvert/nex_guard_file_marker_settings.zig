const WatermarkingStrength = @import("watermarking_strength.zig").WatermarkingStrength;

/// For forensic video watermarking, MediaConvert supports Nagra NexGuard File
/// Marker watermarking. MediaConvert supports both PreRelease Content (NGPR/G2)
/// and OTT Streaming workflows.
pub const NexGuardFileMarkerSettings = struct {
    /// Use the base64 license string that Nagra provides you. Enter it directly in
    /// your JSON job specification or in the console. Required when you include
    /// Nagra NexGuard File Marker watermarking in your job.
    license: ?[]const u8 = null,

    /// Specify the payload ID that you want associated with this output. Valid
    /// values vary depending on your Nagra NexGuard forensic watermarking workflow.
    /// Required when you include Nagra NexGuard File Marker watermarking in your
    /// job. For PreRelease Content (NGPR/G2), specify an integer from 1 through
    /// 4,194,303. You must generate a unique ID for each asset you watermark, and
    /// keep a record of which ID you have assigned to each asset. Neither Nagra nor
    /// MediaConvert keep track of the relationship between output files and your
    /// IDs. For OTT Streaming, create two adaptive bitrate (ABR) stacks for each
    /// asset. Do this by setting up two output groups. For one output group, set
    /// the value of Payload ID to 0 in every output. For the other output group,
    /// set Payload ID to 1 in every output.
    payload: ?i32 = null,

    /// Enter one of the watermarking preset strings that Nagra provides you.
    /// Required when you include Nagra NexGuard File Marker watermarking in your
    /// job.
    preset: ?[]const u8 = null,

    /// Optional. Ignore this setting unless Nagra support directs you to specify a
    /// value. When you don't specify a value here, the Nagra NexGuard library uses
    /// its default value.
    strength: ?WatermarkingStrength = null,

    pub const json_field_names = .{
        .license = "License",
        .payload = "Payload",
        .preset = "Preset",
        .strength = "Strength",
    };
};
