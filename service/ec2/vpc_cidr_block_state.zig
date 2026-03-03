const VpcCidrBlockStateCode = @import("vpc_cidr_block_state_code.zig").VpcCidrBlockStateCode;

/// Describes the state of a CIDR block.
pub const VpcCidrBlockState = struct {
    /// The state of the CIDR block.
    state: ?VpcCidrBlockStateCode = null,

    /// A message about the status of the CIDR block, if applicable.
    status_message: ?[]const u8 = null,
};
