/// Use these settings to insert a DVB Network Information Table (NIT) in the
/// transport stream of this output.
pub const DvbNitSettings = struct {
    /// The numeric value placed in the Network Information Table (NIT).
    network_id: ?i32 = null,

    /// The network name text placed in the network_name_descriptor inside the
    /// Network Information Table. Maximum length is 256 characters.
    network_name: ?[]const u8 = null,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    nit_interval: ?i32 = null,

    pub const json_field_names = .{
        .network_id = "NetworkId",
        .network_name = "NetworkName",
        .nit_interval = "NitInterval",
    };
};
