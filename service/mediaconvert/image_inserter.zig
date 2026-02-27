const InsertableImage = @import("insertable_image.zig").InsertableImage;

/// Use the image inserter feature to include a graphic overlay on your video.
/// Enable or disable this feature for each input or output individually. For
/// more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/graphic-overlay.html.
/// This setting is disabled by default.
pub const ImageInserter = struct {
    /// Specify the images that you want to overlay on your video. The images must
    /// be PNG or TGA files.
    insertable_images: ?[]const InsertableImage,

    /// Specify the reference white level, in nits, for all of your image inserter
    /// images. Use to correct brightness levels within HDR10 outputs. For 1,000 nit
    /// peak brightness displays, we recommend that you set SDR reference white
    /// level to 203 (according to ITU-R BT.2408). Leave blank to use the default
    /// value of 100, or specify an integer from 100 to 1000.
    sdr_reference_white_level: ?i32,

    pub const json_field_names = .{
        .insertable_images = "InsertableImages",
        .sdr_reference_white_level = "SdrReferenceWhiteLevel",
    };
};
