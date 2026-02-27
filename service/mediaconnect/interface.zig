/// The VPC interface that is used for the media stream associated with the
/// source or output.
pub const Interface = struct {
    /// The name of the VPC interface.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
