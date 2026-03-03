const EsamManifestConfirmConditionNotification = @import("esam_manifest_confirm_condition_notification.zig").EsamManifestConfirmConditionNotification;
const EsamSignalProcessingNotification = @import("esam_signal_processing_notification.zig").EsamSignalProcessingNotification;

/// Settings for Event Signaling And Messaging (ESAM). If you don't do ad
/// insertion, you can ignore these settings.
pub const EsamSettings = struct {
    /// Specifies an ESAM ManifestConfirmConditionNotification XML as per
    /// OC-SP-ESAM-API-I03-131025. The transcoder uses the manifest conditioning
    /// instructions that you provide in the setting MCC XML.
    manifest_confirm_condition_notification: ?EsamManifestConfirmConditionNotification = null,

    /// Specifies the stream distance, in milliseconds, between the SCTE 35 messages
    /// that the transcoder places and the splice points that they refer to. If the
    /// time between the start of the asset and the SCTE-35 message is less than
    /// this value, then the transcoder places the SCTE-35 marker at the beginning
    /// of the stream.
    response_signal_preroll: ?i32 = null,

    /// Specifies an ESAM SignalProcessingNotification XML as per
    /// OC-SP-ESAM-API-I03-131025. The transcoder uses the signal processing
    /// instructions that you provide in the setting SCC XML.
    signal_processing_notification: ?EsamSignalProcessingNotification = null,

    pub const json_field_names = .{
        .manifest_confirm_condition_notification = "ManifestConfirmConditionNotification",
        .response_signal_preroll = "ResponseSignalPreroll",
        .signal_processing_notification = "SignalProcessingNotification",
    };
};
