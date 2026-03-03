const GlobalConfigurationInputEndAction = @import("global_configuration_input_end_action.zig").GlobalConfigurationInputEndAction;
const InputLossBehavior = @import("input_loss_behavior.zig").InputLossBehavior;
const GlobalConfigurationOutputLockingMode = @import("global_configuration_output_locking_mode.zig").GlobalConfigurationOutputLockingMode;
const OutputLockingSettings = @import("output_locking_settings.zig").OutputLockingSettings;
const GlobalConfigurationOutputTimingSource = @import("global_configuration_output_timing_source.zig").GlobalConfigurationOutputTimingSource;
const GlobalConfigurationLowFramerateInputs = @import("global_configuration_low_framerate_inputs.zig").GlobalConfigurationLowFramerateInputs;

/// Global Configuration
pub const GlobalConfiguration = struct {
    /// Value to set the initial audio gain for the Live Event.
    initial_audio_gain: ?i32 = null,

    /// Indicates the action to take when the current input completes (e.g.
    /// end-of-file). When switchAndLoopInputs is configured the encoder will
    /// restart at the beginning of the first input. When "none" is configured the
    /// encoder will transcode either black, a solid color, or a user specified
    /// slate images per the "Input Loss Behavior" configuration until the next
    /// input switch occurs (which is controlled through the Channel Schedule API).
    input_end_action: ?GlobalConfigurationInputEndAction = null,

    /// Settings for system actions when input is lost.
    input_loss_behavior: ?InputLossBehavior = null,

    /// Indicates how MediaLive pipelines are synchronized.
    ///
    /// PIPELINE_LOCKING - MediaLive will attempt to synchronize the output of each
    /// pipeline to the other.
    /// EPOCH_LOCKING - MediaLive will attempt to synchronize the output of each
    /// pipeline to the Unix epoch.
    /// DISABLED - MediaLive will not attempt to synchronize the output of
    /// pipelines. We advise against disabling output locking because it has
    /// negative side effects in most workflows. For more information, see the
    /// section about output locking (pipeline locking) in the Medialive user guide.
    output_locking_mode: ?GlobalConfigurationOutputLockingMode = null,

    /// Advanced output locking settings
    output_locking_settings: ?OutputLockingSettings = null,

    /// Indicates whether the rate of frames emitted by the Live encoder should be
    /// paced by its system clock (which optionally may be locked to another source
    /// via NTP) or should be locked to the clock of the source that is providing
    /// the input stream.
    output_timing_source: ?GlobalConfigurationOutputTimingSource = null,

    /// Adjusts video input buffer for streams with very low video framerates. This
    /// is commonly set to enabled for music channels with less than one video frame
    /// per second.
    support_low_framerate_inputs: ?GlobalConfigurationLowFramerateInputs = null,

    pub const json_field_names = .{
        .initial_audio_gain = "InitialAudioGain",
        .input_end_action = "InputEndAction",
        .input_loss_behavior = "InputLossBehavior",
        .output_locking_mode = "OutputLockingMode",
        .output_locking_settings = "OutputLockingSettings",
        .output_timing_source = "OutputTimingSource",
        .support_low_framerate_inputs = "SupportLowFramerateInputs",
    };
};
