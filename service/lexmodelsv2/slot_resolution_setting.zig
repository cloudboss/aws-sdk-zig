const SlotResolutionStrategy = @import("slot_resolution_strategy.zig").SlotResolutionStrategy;

/// Contains information about whether assisted slot resolution is turned on for
/// the slot or not.
pub const SlotResolutionSetting = struct {
    /// Specifies whether assisted slot resolution is turned on for the slot or not.
    /// If the value is `EnhancedFallback`, assisted slot resolution is activated
    /// when Amazon Lex defaults to the `AMAZON.FallbackIntent`. If the value is
    /// `Default`, assisted slot resolution is turned off.
    slot_resolution_strategy: SlotResolutionStrategy,

    pub const json_field_names = .{
        .slot_resolution_strategy = "slotResolutionStrategy",
    };
};
