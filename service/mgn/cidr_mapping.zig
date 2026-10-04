/// Maps a source CIDR range to the corresponding target CIDR range to use in
/// the target network.
pub const CidrMapping = struct {
    /// The original CIDR range in the source network.
    original_cidr: []const u8,

    /// The updated CIDR range to use in the target network.
    updated_cidr: []const u8,

    pub const json_field_names = .{
        .original_cidr = "originalCidr",
        .updated_cidr = "updatedCidr",
    };
};
