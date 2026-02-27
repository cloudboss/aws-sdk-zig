/// The configuration for input switching based on the media quality confidence
/// score (MQCS) as provided from AWS Elemental MediaLive.
pub const InputSwitchConfiguration = struct {
    /// When true, AWS Elemental MediaPackage performs input switching based on the
    /// MQCS. Default is false. This setting is valid only when `InputType` is
    /// `CMAF`.
    mqcs_input_switching: ?bool,

    /// For CMAF inputs, indicates which input MediaPackage should prefer when both
    /// inputs have equal MQCS scores. Select `1` to prefer the first ingest
    /// endpoint, or `2` to prefer the second ingest endpoint. If you don't specify
    /// a preferred input, MediaPackage uses its default switching behavior when
    /// MQCS scores are equal.
    preferred_input: ?i32,

    pub const json_field_names = .{
        .mqcs_input_switching = "MQCSInputSwitching",
        .preferred_input = "PreferredInput",
    };
};
