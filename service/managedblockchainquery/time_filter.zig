const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;

/// This container is used to specify a time frame.
pub const TimeFilter = struct {
    from: ?BlockchainInstant = null,

    to: ?BlockchainInstant = null,

    pub const json_field_names = .{
        .from = "from",
        .to = "to",
    };
};
