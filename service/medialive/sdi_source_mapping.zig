/// Used in DescribeNodeSummary, DescribeNodeResult.
pub const SdiSourceMapping = struct {
    /// A number that uniquely identifies the SDI card on the node hardware.
    card_number: ?i32 = null,

    /// A number that uniquely identifies a port on the SDI card.
    channel_number: ?i32 = null,

    /// The ID of the SdiSource to associate with this port on this card. You can
    /// use the ListSdiSources operation to discover all the IDs.
    sdi_source: ?[]const u8 = null,

    pub const json_field_names = .{
        .card_number = "CardNumber",
        .channel_number = "ChannelNumber",
        .sdi_source = "SdiSource",
    };
};
