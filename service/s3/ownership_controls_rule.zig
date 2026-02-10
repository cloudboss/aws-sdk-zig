const ObjectOwnership = @import("object_ownership.zig").ObjectOwnership;

/// The container element for an ownership control rule.
pub const OwnershipControlsRule = struct {
    object_ownership: ObjectOwnership,
};
