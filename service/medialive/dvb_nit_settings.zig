/// DVB Network Information Table (NIT)
pub const DvbNitSettings = struct {
    /// The numeric value placed in the Network Information Table (NIT).
    network_id: i32,

    /// The network name text placed in the networkNameDescriptor inside the Network
    /// Information Table. Maximum length is 256 characters.
    network_name: []const u8,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    rep_interval: ?i32,

    pub const json_field_names = .{
        .network_id = "NetworkId",
        .network_name = "NetworkName",
        .rep_interval = "RepInterval",
    };
};
