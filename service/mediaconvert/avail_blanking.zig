/// Use ad avail blanking settings to specify your output content during SCTE-35
/// triggered ad avails. You can blank your video or overlay it with an image.
/// MediaConvert also removes any audio and embedded captions during the ad
/// avail. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/ad-avail-blanking.html.
pub const AvailBlanking = struct {
    /// Blanking image to be used. Leave empty for solid black. Only bmp and png
    /// images are supported.
    avail_blanking_image: ?[]const u8,

    pub const json_field_names = .{
        .avail_blanking_image = "AvailBlankingImage",
    };
};
