/// Used in SdiSourceMappingsUpdateRequest. One SDI source mapping. It connects
/// one logical SdiSource to the physical SDI card and port that the physical
/// SDI source uses. You must specify all three parameters in this object.
pub const SdiSourceMappingUpdateRequest = struct {
    /// A number that uniquely identifies the SDI card on the node hardware. For
    /// information about how physical cards are identified on your node hardware,
    /// see the documentation for your node hardware. The numbering always starts at
    /// 1.
    card_number: ?i32 = null,

    /// A number that uniquely identifies a port on the card. This must be an SDI
    /// port (not a timecode port, for example). For information about how ports are
    /// identified on physical cards, see the documentation for your node hardware.
    channel_number: ?i32 = null,

    /// The ID of a SDI source streaming on the given SDI capture card port.
    sdi_source: ?[]const u8 = null,

    pub const json_field_names = .{
        .card_number = "CardNumber",
        .channel_number = "ChannelNumber",
        .sdi_source = "SdiSource",
    };
};
