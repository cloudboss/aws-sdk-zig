/// The metadata information of the LoRaWAN multicast group.
pub const LoRaWANMulticastMetadata = struct {
    f_port: ?i32,

    pub const json_field_names = .{
        .f_port = "FPort",
    };
};
