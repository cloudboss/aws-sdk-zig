const ListingState = @import("listing_state.zig").ListingState;

/// Describes a Reserved Instance listing state.
pub const InstanceCount = struct {
    /// The number of listed Reserved Instances in the state specified by the
    /// `state`.
    instance_count: ?i32 = null,

    /// The states of the listed Reserved Instances.
    state: ?ListingState = null,
};
