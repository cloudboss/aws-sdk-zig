const StreamingMediaFileConditioning = @import("streaming_media_file_conditioning.zig").StreamingMediaFileConditioning;

/// The setting that indicates what conditioning MediaTailor will perform on ads
/// that the ad decision server (ADS) returns.
pub const AdConditioningConfiguration = struct {
    /// For ads that have media files with streaming delivery and supported file
    /// extensions, indicates what transcoding action MediaTailor takes when it
    /// first receives these ads from the ADS. `TRANSCODE` indicates that
    /// MediaTailor must transcode the ads. `NONE` indicates that you have already
    /// transcoded the ads outside of MediaTailor and don't need them transcoded as
    /// part of the ad insertion workflow. For more information about ad
    /// conditioning see [Using preconditioned
    /// ads](https://docs.aws.amazon.com/mediatailor/latest/ug/precondition-ads.html) in the Elemental MediaTailor user guide.
    streaming_media_file_conditioning: StreamingMediaFileConditioning,

    pub const json_field_names = .{
        .streaming_media_file_conditioning = "StreamingMediaFileConditioning",
    };
};
