/// Details about an antenna demod decode `Config` used in a contact.
pub const AntennaDemodDecodeDetails = struct {
    /// Name of an antenna demod decode output node used in a contact.
    output_node: ?[]const u8,

    pub const json_field_names = .{
        .output_node = "outputNode",
    };
};
