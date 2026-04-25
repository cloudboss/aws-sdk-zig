const RenditionConfigurationRendition = @import("rendition_configuration_rendition.zig").RenditionConfigurationRendition;
const RenditionConfigurationRenditionSelection = @import("rendition_configuration_rendition_selection.zig").RenditionConfigurationRenditionSelection;

/// Object that describes which renditions should be recorded for a stream.
pub const RenditionConfiguration = struct {
    /// Indicates which renditions are recorded for a stream, if
    /// `renditionSelection` is `CUSTOM`; otherwise, this field is irrelevant. The
    /// selected renditions are recorded if they are available during the stream. If
    /// a selected rendition is unavailable, the best available rendition is
    /// recorded. For details on the resolution dimensions of each rendition, see
    /// [Auto-Record to Amazon
    /// S3](https://docs.aws.amazon.com/ivs/latest/userguide/record-to-s3.html).
    renditions: ?[]const RenditionConfigurationRendition = null,

    /// Indicates which set of renditions are recorded for a stream. For `BASIC`
    /// channels, the `CUSTOM` value has no effect. If `CUSTOM` is specified, a set
    /// of renditions must be specified in the `renditions` field. Default: `ALL`.
    rendition_selection: ?RenditionConfigurationRenditionSelection = null,

    pub const json_field_names = .{
        .renditions = "renditions",
        .rendition_selection = "renditionSelection",
    };
};
