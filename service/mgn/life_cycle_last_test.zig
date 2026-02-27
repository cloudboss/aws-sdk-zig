const LifeCycleLastTestFinalized = @import("life_cycle_last_test_finalized.zig").LifeCycleLastTestFinalized;
const LifeCycleLastTestInitiated = @import("life_cycle_last_test_initiated.zig").LifeCycleLastTestInitiated;
const LifeCycleLastTestReverted = @import("life_cycle_last_test_reverted.zig").LifeCycleLastTestReverted;

/// Lifecycle last Test.
pub const LifeCycleLastTest = struct {
    /// Lifecycle last Test finalized.
    finalized: ?LifeCycleLastTestFinalized,

    /// Lifecycle last Test initiated.
    initiated: ?LifeCycleLastTestInitiated,

    /// Lifecycle last Test reverted.
    reverted: ?LifeCycleLastTestReverted,

    pub const json_field_names = .{
        .finalized = "finalized",
        .initiated = "initiated",
        .reverted = "reverted",
    };
};
