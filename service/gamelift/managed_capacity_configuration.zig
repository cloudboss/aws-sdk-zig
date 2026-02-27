const ZeroCapacityStrategy = @import("zero_capacity_strategy.zig").ZeroCapacityStrategy;

/// Use ManagedCapacityConfiguration with the "SCALE_TO_AND_FROM_ZERO"
/// ZeroCapacityStrategy to enable Amazon
/// GameLift Servers to fully manage the MinSize value, switching between 0 and
/// 1 based on game session
/// activity. This is ideal for eliminating compute costs during periods of no
/// game activity.
/// It is particularly beneficial during development when you're away from your
/// desk, iterating on builds
/// for extended periods, in production environments serving low-traffic
/// locations, or for games with long,
/// predictable downtime windows. By automatically managing capacity between 0
/// and 1 instances, you avoid paying
/// for idle instances while maintaining the ability to serve game sessions when
/// demand arrives. Note that while
/// scale-out is triggered immediately upon receiving a game session request,
/// actual game session availability
/// depends on your server process startup time, so this approach works best
/// with multi-location Fleets where
/// cold-start latency is tolerable. With a "MANUAL" ZeroCapacityStrategy Amazon
/// GameLift Servers will not
/// modify Fleet MinSize values automatically and will not scale out from zero
/// instances in response to game
/// sessions.
pub const ManagedCapacityConfiguration = struct {
    /// Length of time, in minutes, that Amazon GameLift Servers will wait before
    /// scaling in your MinSize and
    /// DesiredInstances to 0 after a period with no game session activity. Default:
    /// 30 minutes.
    scale_in_after_inactivity_minutes: ?i32,

    /// The strategy Amazon GameLift Servers will use to automatically scale your
    /// capacity to and from zero
    /// instances in response to game session activity. Game session activity refers
    /// to any active running sessions
    /// or game session requests.
    ///
    /// Possible ZeroCapacityStrategy types include:
    ///
    /// * **MANUAL** -- (default value) Amazon GameLift Servers will not update
    /// capacity to and from zero on your behalf.
    ///
    /// * **SCALE_TO_AND_FROM_ZERO** -- Amazon GameLift Servers will automatically
    /// scale out MinSize and DesiredInstances from 0 to 1 in response to a game
    /// session request, and will scale
    /// in MinSize and DesiredInstances to 0 after a period with no game session
    /// activity. The duration of
    /// this scale in period can be configured using ScaleInAfterInactivityMinutes.
    zero_capacity_strategy: ?ZeroCapacityStrategy,

    pub const json_field_names = .{
        .scale_in_after_inactivity_minutes = "ScaleInAfterInactivityMinutes",
        .zero_capacity_strategy = "ZeroCapacityStrategy",
    };
};
