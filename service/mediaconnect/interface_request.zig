/// The VPC interface that you want to designate where the media stream is
/// coming from or going to.
pub const InterfaceRequest = struct {
    /// The name of the VPC interface.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
