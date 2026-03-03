/// Details about the MemoryDB reservations that Amazon Web Services recommends
/// that you
/// purchase.
pub const MemoryDBInstanceDetails = struct {
    /// Determines whether the recommendation is for a current generation instance.
    current_generation: bool = false,

    /// The instance family of the recommended reservation.
    family: ?[]const u8 = null,

    /// The node type of the recommended reservation.
    node_type: ?[]const u8 = null,

    /// The Amazon Web Services Region of the recommended reservation.
    region: ?[]const u8 = null,

    /// Determines whether the recommended reservation is size flexible.
    size_flex_eligible: bool = false,

    pub const json_field_names = .{
        .current_generation = "CurrentGeneration",
        .family = "Family",
        .node_type = "NodeType",
        .region = "Region",
        .size_flex_eligible = "SizeFlexEligible",
    };
};
