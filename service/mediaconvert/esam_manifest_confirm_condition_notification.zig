/// ESAM ManifestConfirmConditionNotification defined by
/// OC-SP-ESAM-API-I03-131025.
pub const EsamManifestConfirmConditionNotification = struct {
    /// Provide your ESAM ManifestConfirmConditionNotification XML document inside
    /// your JSON job settings. Form the XML document as per
    /// OC-SP-ESAM-API-I03-131025. The transcoder will use the Manifest Conditioning
    /// instructions in the message that you supply.
    mcc_xml: ?[]const u8 = null,

    pub const json_field_names = .{
        .mcc_xml = "MccXml",
    };
};
