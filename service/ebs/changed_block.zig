/// A block of data in an Amazon Elastic Block Store snapshot that is different
/// from another snapshot of
/// the same volume/snapshot lineage.
pub const ChangedBlock = struct {
    /// The block index.
    block_index: ?i32 = null,

    /// The block token for the block index of the `FirstSnapshotId` specified in
    /// the `ListChangedBlocks` operation. This value is absent if the first
    /// snapshot
    /// does not have the changed block that is on the second snapshot.
    first_block_token: ?[]const u8 = null,

    /// The block token for the block index of the `SecondSnapshotId` specified in
    /// the `ListChangedBlocks` operation.
    second_block_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .block_index = "BlockIndex",
        .first_block_token = "FirstBlockToken",
        .second_block_token = "SecondBlockToken",
    };
};
