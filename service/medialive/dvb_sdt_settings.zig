const DvbSdtOutputSdt = @import("dvb_sdt_output_sdt.zig").DvbSdtOutputSdt;

/// DVB Service Description Table (SDT)
pub const DvbSdtSettings = struct {
    /// Selects method of inserting SDT information into output stream. The
    /// sdtFollow setting copies SDT information from input stream to output stream.
    /// The sdtFollowIfPresent setting copies SDT information from input stream to
    /// output stream if SDT information is present in the input, otherwise it will
    /// fall back on the user-defined values. The sdtManual setting means user will
    /// enter the SDT information. The sdtNone setting means output stream will not
    /// contain SDT information.
    output_sdt: ?DvbSdtOutputSdt,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    rep_interval: ?i32,

    /// The service name placed in the serviceDescriptor in the Service Description
    /// Table. Maximum length is 256 characters.
    service_name: ?[]const u8,

    /// The service provider name placed in the serviceDescriptor in the Service
    /// Description Table. Maximum length is 256 characters.
    service_provider_name: ?[]const u8,

    pub const json_field_names = .{
        .output_sdt = "OutputSdt",
        .rep_interval = "RepInterval",
        .service_name = "ServiceName",
        .service_provider_name = "ServiceProviderName",
    };
};
