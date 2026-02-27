const LifeCycleLastCutoverFinalized = @import("life_cycle_last_cutover_finalized.zig").LifeCycleLastCutoverFinalized;
const LifeCycleLastCutoverInitiated = @import("life_cycle_last_cutover_initiated.zig").LifeCycleLastCutoverInitiated;
const LifeCycleLastCutoverReverted = @import("life_cycle_last_cutover_reverted.zig").LifeCycleLastCutoverReverted;

/// Lifecycle last Cutover .
pub const LifeCycleLastCutover = struct {
    /// Lifecycle Cutover finalized date and time.
    finalized: ?LifeCycleLastCutoverFinalized,

    /// Lifecycle last Cutover initiated.
    initiated: ?LifeCycleLastCutoverInitiated,

    /// Lifecycle last Cutover reverted.
    reverted: ?LifeCycleLastCutoverReverted,

    pub const json_field_names = .{
        .finalized = "finalized",
        .initiated = "initiated",
        .reverted = "reverted",
    };
};
