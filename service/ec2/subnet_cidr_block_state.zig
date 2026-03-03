const SubnetCidrBlockStateCode = @import("subnet_cidr_block_state_code.zig").SubnetCidrBlockStateCode;

/// Describes the state of a CIDR block.
pub const SubnetCidrBlockState = struct {
    /// The state of a CIDR block.
    state: ?SubnetCidrBlockStateCode = null,

    /// A message about the status of the CIDR block, if applicable.
    status_message: ?[]const u8 = null,
};
