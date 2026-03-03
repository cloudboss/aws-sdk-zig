const OutputSdt = @import("output_sdt.zig").OutputSdt;

/// Use these settings to insert a DVB Service Description Table (SDT) in the
/// transport stream of this output.
pub const DvbSdtSettings = struct {
    /// Selects method of inserting SDT information into output stream. "Follow
    /// input SDT" copies SDT information from input stream to output stream.
    /// "Follow input SDT if present" copies SDT information from input stream to
    /// output stream if SDT information is present in the input, otherwise it will
    /// fall back on the user-defined values. Enter "SDT Manually" means user will
    /// enter the SDT information. "No SDT" means output stream will not contain SDT
    /// information.
    output_sdt: ?OutputSdt = null,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    sdt_interval: ?i32 = null,

    /// The service name placed in the service_descriptor in the Service Description
    /// Table. Maximum length is 256 characters.
    service_name: ?[]const u8 = null,

    /// The service provider name placed in the service_descriptor in the Service
    /// Description Table. Maximum length is 256 characters.
    service_provider_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_sdt = "OutputSdt",
        .sdt_interval = "SdtInterval",
        .service_name = "ServiceName",
        .service_provider_name = "ServiceProviderName",
    };
};
