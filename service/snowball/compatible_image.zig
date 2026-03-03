/// A JSON-formatted object that describes a compatible Amazon Machine Image
/// (AMI),
/// including the ID and name for a Snow device AMI. This AMI is compatible with
/// the device's
/// physical hardware requirements, and it should be able to be run in an SBE1
/// instance on the
/// device.
pub const CompatibleImage = struct {
    /// The unique identifier for an individual Snow device AMI.
    ami_id: ?[]const u8 = null,

    /// The optional name of a compatible image.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .ami_id = "AmiId",
        .name = "Name",
    };
};
