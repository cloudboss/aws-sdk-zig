const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const FrameCaptureCdnSettings = @import("frame_capture_cdn_settings.zig").FrameCaptureCdnSettings;

/// Frame Capture Group Settings
pub const FrameCaptureGroupSettings = struct {
    /// The destination for the frame capture files. Either the URI for an Amazon S3
    /// bucket and object, plus a file name prefix (for example,
    /// s3ssl://sportsDelivery/highlights/20180820/curling-) or the URI for a
    /// MediaStore container, plus a file name prefix (for example,
    /// mediastoressl://sportsDelivery/20180820/curling-). The final file names
    /// consist of the prefix from the destination field (for example, "curling-") +
    /// name modifier + the counter (5 digits, starting from 00001) + extension
    /// (which is always .jpg). For example, curling-low.00001.jpg
    destination: OutputLocationRef,

    /// Parameters that control interactions with the CDN.
    frame_capture_cdn_settings: ?FrameCaptureCdnSettings = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .frame_capture_cdn_settings = "FrameCaptureCdnSettings",
    };
};
