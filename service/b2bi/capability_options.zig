const InboundEdiOptions = @import("inbound_edi_options.zig").InboundEdiOptions;
const OutboundEdiOptions = @import("outbound_edi_options.zig").OutboundEdiOptions;

/// Contains the details for an Outbound EDI capability.
pub const CapabilityOptions = struct {
    /// A structure that contains the inbound EDI options for the capability.
    inbound_edi: ?InboundEdiOptions,

    /// A structure that contains the outbound EDI options.
    outbound_edi: ?OutboundEdiOptions,

    pub const json_field_names = .{
        .inbound_edi = "inboundEdi",
        .outbound_edi = "outboundEdi",
    };
};
