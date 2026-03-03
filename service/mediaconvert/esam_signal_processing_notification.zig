/// ESAM SignalProcessingNotification data defined by OC-SP-ESAM-API-I03-131025.
pub const EsamSignalProcessingNotification = struct {
    /// Provide your ESAM SignalProcessingNotification XML document inside your JSON
    /// job settings. Form the XML document as per OC-SP-ESAM-API-I03-131025. The
    /// transcoder will use the signal processing instructions in the message that
    /// you supply. For your MPEG2-TS file outputs, if you want the service to place
    /// SCTE-35 markers at the insertion points you specify in the XML document, you
    /// must also enable SCTE-35 ESAM. Note that you can either specify an ESAM XML
    /// document or enable SCTE-35 passthrough. You can't do both.
    scc_xml: ?[]const u8 = null,

    pub const json_field_names = .{
        .scc_xml = "SccXml",
    };
};
