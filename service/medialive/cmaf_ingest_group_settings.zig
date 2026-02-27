const AdditionalDestinations = @import("additional_destinations.zig").AdditionalDestinations;
const CmafIngestCaptionLanguageMapping = @import("cmaf_ingest_caption_language_mapping.zig").CmafIngestCaptionLanguageMapping;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const CmafId3Behavior = @import("cmaf_id_3_behavior.zig").CmafId3Behavior;
const CmafKLVBehavior = @import("cmaf_klv_behavior.zig").CmafKLVBehavior;
const CmafNielsenId3Behavior = @import("cmaf_nielsen_id_3_behavior.zig").CmafNielsenId3Behavior;
const Scte35Type = @import("scte_35_type.zig").Scte35Type;
const CmafIngestSegmentLengthUnits = @import("cmaf_ingest_segment_length_units.zig").CmafIngestSegmentLengthUnits;
const CmafTimedMetadataId3Frame = @import("cmaf_timed_metadata_id_3_frame.zig").CmafTimedMetadataId3Frame;
const CmafTimedMetadataPassthrough = @import("cmaf_timed_metadata_passthrough.zig").CmafTimedMetadataPassthrough;

/// Cmaf Ingest Group Settings
pub const CmafIngestGroupSettings = struct {
    /// Optional an array of additional destinational HTTP destinations for the
    /// OutputGroup outputs
    additional_destinations: ?[]const AdditionalDestinations,

    /// An array that identifies the languages in the four caption channels in the
    /// embedded captions.
    caption_language_mappings: ?[]const CmafIngestCaptionLanguageMapping,

    /// A HTTP destination for the tracks
    destination: OutputLocationRef,

    /// Set to ENABLED to enable ID3 metadata insertion. To include metadata, you
    /// configure other parameters in the output group, or you add an ID3 action to
    /// the channel schedule.
    id_3_behavior: ?CmafId3Behavior,

    /// Change the modifier that MediaLive automatically adds to the Streams() name
    /// that identifies an ID3 track. The default is "id3", which means the default
    /// name will be Streams(id3.cmfm). Any string you enter here will replace the
    /// "id3" string.\nThe modifier can only contain: numbers, letters, plus (+),
    /// minus (-), underscore (_) and period (.) and has a maximum length of 100
    /// characters.
    id_3_name_modifier: ?[]const u8,

    /// If set to passthrough, passes any KLV data from the input source to this
    /// output.
    klv_behavior: ?CmafKLVBehavior,

    /// Change the modifier that MediaLive automatically adds to the Streams() name
    /// that identifies a KLV track. The default is "klv", which means the default
    /// name will be Streams(klv.cmfm). Any string you enter here will replace the
    /// "klv" string.\nThe modifier can only contain: numbers, letters, plus (+),
    /// minus (-), underscore (_) and period (.) and has a maximum length of 100
    /// characters.
    klv_name_modifier: ?[]const u8,

    /// If set to passthrough, Nielsen inaudible tones for media tracking will be
    /// detected in the input audio and an equivalent ID3 tag will be inserted in
    /// the output.
    nielsen_id_3_behavior: ?CmafNielsenId3Behavior,

    /// Change the modifier that MediaLive automatically adds to the Streams() name
    /// that identifies a Nielsen ID3 track. The default is "nid3", which means the
    /// default name will be Streams(nid3.cmfm). Any string you enter here will
    /// replace the "nid3" string.\nThe modifier can only contain: numbers, letters,
    /// plus (+), minus (-), underscore (_) and period (.) and has a maximum length
    /// of 100 characters.
    nielsen_id_3_name_modifier: ?[]const u8,

    /// Change the modifier that MediaLive automatically adds to the Streams() name
    /// for a SCTE 35 track. The default is "scte", which means the default name
    /// will be Streams(scte.cmfm). Any string you enter here will replace the
    /// "scte" string.\nThe modifier can only contain: numbers, letters, plus (+),
    /// minus (-), underscore (_) and period (.) and has a maximum length of 100
    /// characters.
    scte_35_name_modifier: ?[]const u8,

    /// Type of scte35 track to add. none or scte35WithoutSegmentation
    scte_35_type: ?Scte35Type,

    /// The nominal duration of segments. The units are specified in
    /// SegmentLengthUnits. The segments will end on the next keyframe after the
    /// specified duration, so the actual segment length might be longer, and it
    /// might be a fraction of the units.
    segment_length: ?i32,

    /// Time unit for segment length parameter.
    segment_length_units: ?CmafIngestSegmentLengthUnits,

    /// Number of milliseconds to delay the output from the second pipeline.
    send_delay_ms: ?i32,

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
        .destination = "Destination",
        .id_3_behavior = "Id3Behavior",
        .id_3_name_modifier = "Id3NameModifier",
        .klv_behavior = "KlvBehavior",
        .klv_name_modifier = "KlvNameModifier",
        .nielsen_id_3_behavior = "NielsenId3Behavior",
        .nielsen_id_3_name_modifier = "NielsenId3NameModifier",
        .scte_35_name_modifier = "Scte35NameModifier",
        .scte_35_type = "Scte35Type",
        .segment_length = "SegmentLength",
        .segment_length_units = "SegmentLengthUnits",
        .send_delay_ms = "SendDelayMs",
        .timed_metadata_id_3_frame = "TimedMetadataId3Frame",
        .timed_metadata_id_3_period = "TimedMetadataId3Period",
        .timed_metadata_passthrough = "TimedMetadataPassthrough",
    };
};
