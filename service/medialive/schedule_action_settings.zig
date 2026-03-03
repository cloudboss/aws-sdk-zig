const HlsId3SegmentTaggingScheduleActionSettings = @import("hls_id_3_segment_tagging_schedule_action_settings.zig").HlsId3SegmentTaggingScheduleActionSettings;
const HlsTimedMetadataScheduleActionSettings = @import("hls_timed_metadata_schedule_action_settings.zig").HlsTimedMetadataScheduleActionSettings;
const Id3SegmentTaggingScheduleActionSettings = @import("id_3_segment_tagging_schedule_action_settings.zig").Id3SegmentTaggingScheduleActionSettings;
const InputPrepareScheduleActionSettings = @import("input_prepare_schedule_action_settings.zig").InputPrepareScheduleActionSettings;
const InputSwitchScheduleActionSettings = @import("input_switch_schedule_action_settings.zig").InputSwitchScheduleActionSettings;
const MotionGraphicsActivateScheduleActionSettings = @import("motion_graphics_activate_schedule_action_settings.zig").MotionGraphicsActivateScheduleActionSettings;
const MotionGraphicsDeactivateScheduleActionSettings = @import("motion_graphics_deactivate_schedule_action_settings.zig").MotionGraphicsDeactivateScheduleActionSettings;
const PauseStateScheduleActionSettings = @import("pause_state_schedule_action_settings.zig").PauseStateScheduleActionSettings;
const Scte35InputScheduleActionSettings = @import("scte_35_input_schedule_action_settings.zig").Scte35InputScheduleActionSettings;
const Scte35ReturnToNetworkScheduleActionSettings = @import("scte_35_return_to_network_schedule_action_settings.zig").Scte35ReturnToNetworkScheduleActionSettings;
const Scte35SpliceInsertScheduleActionSettings = @import("scte_35_splice_insert_schedule_action_settings.zig").Scte35SpliceInsertScheduleActionSettings;
const Scte35TimeSignalScheduleActionSettings = @import("scte_35_time_signal_schedule_action_settings.zig").Scte35TimeSignalScheduleActionSettings;
const StaticImageActivateScheduleActionSettings = @import("static_image_activate_schedule_action_settings.zig").StaticImageActivateScheduleActionSettings;
const StaticImageDeactivateScheduleActionSettings = @import("static_image_deactivate_schedule_action_settings.zig").StaticImageDeactivateScheduleActionSettings;
const StaticImageOutputActivateScheduleActionSettings = @import("static_image_output_activate_schedule_action_settings.zig").StaticImageOutputActivateScheduleActionSettings;
const StaticImageOutputDeactivateScheduleActionSettings = @import("static_image_output_deactivate_schedule_action_settings.zig").StaticImageOutputDeactivateScheduleActionSettings;
const TimedMetadataScheduleActionSettings = @import("timed_metadata_schedule_action_settings.zig").TimedMetadataScheduleActionSettings;

/// Holds the settings for a single schedule action.
pub const ScheduleActionSettings = struct {
    /// Action to insert ID3 metadata in every segment, in HLS output groups
    hls_id_3_segment_tagging_settings: ?HlsId3SegmentTaggingScheduleActionSettings = null,

    /// Action to insert ID3 metadata once, in HLS output groups
    hls_timed_metadata_settings: ?HlsTimedMetadataScheduleActionSettings = null,

    /// Action to insert ID3 metadata in every segment, in applicable output groups
    id_3_segment_tagging_settings: ?Id3SegmentTaggingScheduleActionSettings = null,

    /// Action to prepare an input for a future immediate input switch
    input_prepare_settings: ?InputPrepareScheduleActionSettings = null,

    /// Action to switch the input
    input_switch_settings: ?InputSwitchScheduleActionSettings = null,

    /// Action to activate a motion graphics image overlay
    motion_graphics_image_activate_settings: ?MotionGraphicsActivateScheduleActionSettings = null,

    /// Action to deactivate a motion graphics image overlay
    motion_graphics_image_deactivate_settings: ?MotionGraphicsDeactivateScheduleActionSettings = null,

    /// Action to pause or unpause one or both channel pipelines
    pause_state_settings: ?PauseStateScheduleActionSettings = null,

    /// Action to specify scte35 input
    scte_35_input_settings: ?Scte35InputScheduleActionSettings = null,

    /// Action to insert SCTE-35 return_to_network message
    scte_35_return_to_network_settings: ?Scte35ReturnToNetworkScheduleActionSettings = null,

    /// Action to insert SCTE-35 splice_insert message
    scte_35_splice_insert_settings: ?Scte35SpliceInsertScheduleActionSettings = null,

    /// Action to insert SCTE-35 time_signal message
    scte_35_time_signal_settings: ?Scte35TimeSignalScheduleActionSettings = null,

    /// Action to activate a static image overlay
    static_image_activate_settings: ?StaticImageActivateScheduleActionSettings = null,

    /// Action to deactivate a static image overlay
    static_image_deactivate_settings: ?StaticImageDeactivateScheduleActionSettings = null,

    /// Action to activate a static image overlay in one or more specified outputs
    static_image_output_activate_settings: ?StaticImageOutputActivateScheduleActionSettings = null,

    /// Action to deactivate a static image overlay in one or more specified outputs
    static_image_output_deactivate_settings: ?StaticImageOutputDeactivateScheduleActionSettings = null,

    /// Action to insert ID3 metadata once, in applicable output groups
    timed_metadata_settings: ?TimedMetadataScheduleActionSettings = null,

    pub const json_field_names = .{
        .hls_id_3_segment_tagging_settings = "HlsId3SegmentTaggingSettings",
        .hls_timed_metadata_settings = "HlsTimedMetadataSettings",
        .id_3_segment_tagging_settings = "Id3SegmentTaggingSettings",
        .input_prepare_settings = "InputPrepareSettings",
        .input_switch_settings = "InputSwitchSettings",
        .motion_graphics_image_activate_settings = "MotionGraphicsImageActivateSettings",
        .motion_graphics_image_deactivate_settings = "MotionGraphicsImageDeactivateSettings",
        .pause_state_settings = "PauseStateSettings",
        .scte_35_input_settings = "Scte35InputSettings",
        .scte_35_return_to_network_settings = "Scte35ReturnToNetworkSettings",
        .scte_35_splice_insert_settings = "Scte35SpliceInsertSettings",
        .scte_35_time_signal_settings = "Scte35TimeSignalSettings",
        .static_image_activate_settings = "StaticImageActivateSettings",
        .static_image_deactivate_settings = "StaticImageDeactivateSettings",
        .static_image_output_activate_settings = "StaticImageOutputActivateSettings",
        .static_image_output_deactivate_settings = "StaticImageOutputDeactivateSettings",
        .timed_metadata_settings = "TimedMetadataSettings",
    };
};
