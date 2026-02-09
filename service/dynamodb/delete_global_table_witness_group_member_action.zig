/// Specifies the action to remove a witness Region from a MRSC global table.
/// You cannot
/// delete a single witness from a MRSC global table - you must delete both a
/// replica and
/// the witness together. The deletion of both a witness and replica converts
/// the remaining
/// replica to a single-Region DynamoDB table.
pub const DeleteGlobalTableWitnessGroupMemberAction = struct {
    /// The witness Region name to be removed from the MRSC global table.
    region_name: []const u8,
};
