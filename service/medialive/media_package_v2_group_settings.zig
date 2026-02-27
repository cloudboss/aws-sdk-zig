const MediaPackageAdditionalDestinations = @import("media_package_additional_destinations.zig").MediaPackageAdditionalDestinations;
const CaptionLanguageMapping = @import("caption_language_mapping.zig").CaptionLanguageMapping;
const CmafId3Behavior = @import("cmaf_id_3_behavior.zig").CmafId3Behavior;
const CmafKLVBehavior = @import("cmaf_klv_behavior.zig").CmafKLVBehavior;
const CmafNielsenId3Behavior = @import("cmaf_nielsen_id_3_behavior.zig").CmafNielsenId3Behavior;
const Scte35Type = @import("scte_35_type.zig").Scte35Type;
const CmafIngestSegmentLengthUnits = @import("cmaf_ingest_segment_length_units.zig").CmafIngestSegmentLengthUnits;
const CmafTimedMetadataId3Frame = @import("cmaf_timed_metadata_id_3_frame.zig").CmafTimedMetadataId3Frame;
const CmafTimedMetadataPassthrough = @import("cmaf_timed_metadata_passthrough.zig").CmafTimedMetadataPassthrough;

/// Media Package V2 Group Settings
pub const MediaPackageV2GroupSettings = struct {
    /// Optional an array of additional destinational HTTP destinations for the
    /// OutputGroup outputs
    additional_destinations: ?[]const MediaPackageAdditionalDestinations,

    /// Mapping of up to 4 caption channels to caption languages.
    caption_language_mappings: ?[]const CaptionLanguageMapping,

    /// Set to ENABLED to enable ID3 metadata insertion. To include metadata, you
    /// configure other parameters in the output group, or you add an ID3 action to
    /// the channel schedule.
    id_3_behavior: ?CmafId3Behavior,

    /// If set to passthrough, passes any KLV data from the input source to this
    /// output.
    klv_behavior: ?CmafKLVBehavior,

    /// If set to passthrough, Nielsen inaudible tones for media tracking will be
    /// detected in the input audio and an equivalent ID3 tag will be inserted in
    /// the output.
    nielsen_id_3_behavior: ?CmafNielsenId3Behavior,

    /// Type of scte35 track to add. none or scte35WithoutSegmentation
    scte_35_type: ?Scte35Type,

    /// The nominal duration of segments. The units are specified in
    /// SegmentLengthUnits. The segments will end on the next keyframe after the
    /// specified duration, so the actual segment length might be longer, and it
    /// might be a fraction of the units.
    segment_length: ?i32,

    /// Time unit for segment length parameter.
    segment_length_units: ?CmafIngestSegmentLengthUnits,

    /// Set to none if you don't want to insert a timecode in the output. Otherwise
    /// choose the frame type for the timecode.
    timed_metadata_id_3_frame: ?CmafTimedMetadataId3Frame,

    /// If you set up to insert a timecode in the output, specify the frequency for
    /// the frame, in seconds.
    timed_metadata_id_3_period: ?i32,

    /// Set to enabled to pass through ID3 metadata from the input sources.
    timed_metadata_passthrough: ?CmafTimedMetadataPassthrough,

    pub const json_field_names = .{
        .additional_destinations = "AdditionalDestinations",
        .caption_language_mappings = "CaptionLanguageMappings",
        .id_3_behavior = "Id3Behavior",
        .klv_behavior = "KlvBehavior",
        .nielsen_id_3_behavior = "NielsenId3Behavior",
        .scte_35_type = "Scte35Type",
        .segment_length = "SegmentLength",
        .segment_length_units = "SegmentLengthUnits",
        .timed_metadata_id_3_frame = "TimedMetadataId3Frame",
        .timed_metadata_id_3_period = "TimedMetadataId3Period",
        .timed_metadata_passthrough = "TimedMetadataPassthrough",
    };
};
