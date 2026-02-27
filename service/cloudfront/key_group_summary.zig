const KeyGroup = @import("key_group.zig").KeyGroup;

/// Contains information about a key group.
pub const KeyGroupSummary = struct {
    /// A key group.
    key_group: KeyGroup,
};
