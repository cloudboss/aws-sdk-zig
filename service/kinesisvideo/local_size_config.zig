const StrategyOnFullSize = @import("strategy_on_full_size.zig").StrategyOnFullSize;

/// The configuration details that include the maximum size of the media
/// (`MaxLocalMediaSizeInMB`) that you want to
/// store for a stream on the Edge Agent, as well as the strategy that should be
/// used (`StrategyOnFullSize`) when a stream's
/// maximum size has been reached.
pub const LocalSizeConfig = struct {
    /// The overall maximum size of the media that you want to store for a stream on
    /// the Edge Agent.
    max_local_media_size_in_mb: ?i32,

    /// The strategy to perform when a stream’s `MaxLocalMediaSizeInMB` limit is
    /// reached.
    strategy_on_full_size: ?StrategyOnFullSize,

    pub const json_field_names = .{
        .max_local_media_size_in_mb = "MaxLocalMediaSizeInMB",
        .strategy_on_full_size = "StrategyOnFullSize",
    };
};
