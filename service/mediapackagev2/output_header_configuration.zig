/// The settings for what common media server data (CMSD) headers AWS Elemental
/// MediaPackage includes in responses to the CDN.
pub const OutputHeaderConfiguration = struct {
    /// When true, AWS Elemental MediaPackage includes the MQCS in responses to the
    /// CDN. This setting is valid only when `InputType` is `CMAF`.
    publish_mqcs: ?bool = null,

    pub const json_field_names = .{
        .publish_mqcs = "PublishMQCS",
    };
};
