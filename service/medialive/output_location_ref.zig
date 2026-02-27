/// Reference to an OutputDestination ID defined in the channel
pub const OutputLocationRef = struct {
    destination_ref_id: ?[]const u8,

    pub const json_field_names = .{
        .destination_ref_id = "DestinationRefId",
    };
};
