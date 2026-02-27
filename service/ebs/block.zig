/// A block of data in an Amazon Elastic Block Store snapshot.
pub const Block = struct {
    /// The block index.
    block_index: ?i32,

    /// The block token for the block index.
    block_token: ?[]const u8,

    pub const json_field_names = .{
        .block_index = "BlockIndex",
        .block_token = "BlockToken",
    };
};
