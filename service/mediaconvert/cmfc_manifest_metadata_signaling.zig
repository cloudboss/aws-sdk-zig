/// To add an InbandEventStream element in your output MPD manifest for each
/// type of event message, set Manifest metadata signaling to Enabled. For ID3
/// event messages, the InbandEventStream element schemeIdUri will be same value
/// that you specify for ID3 metadata scheme ID URI. For SCTE35 event messages,
/// the InbandEventStream element schemeIdUri will be
/// "urn:scte:scte35:2013:bin". To leave these elements out of your output MPD
/// manifest, set Manifest metadata signaling to Disabled. To enable Manifest
/// metadata signaling, you must also set SCTE-35 source to Passthrough, ESAM
/// SCTE-35 to insert, or ID3 metadata to Passthrough.
pub const CmfcManifestMetadataSignaling = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
